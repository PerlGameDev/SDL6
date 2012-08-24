module NativeCall;

# Throwaway type just to get us some way to get at the NativeCall
# representation.
my class native_callsite is repr('NativeCall') { }

# Maps a chosen string encoding to a type recognized by the native call engine.
sub string_encoding_to_nci_type($enc) {
    given $enc {
        when 'utf8'  { 'utf8str'  }
        when 'utf16' { 'utf16str' }
        when 'ascii' { 'asciistr' }
        default      { die "Unknown string encoding for native call: $enc"; }
    }
}

# Builds a hash of type information for the specified parameter.
sub param_hash_for(Parameter $p, :$with-typeobj) {
    my Mu $result := nqp::hash();
    my $type := $p.type();
    nqp::bindkey($result, 'typeobj', $type) if $with-typeobj;
    if $type ~~ Str {
        my $enc := $p.?native_call_encoded() || 'utf8';
        nqp::bindkey($result, 'type', nqp::unbox_s(string_encoding_to_nci_type($enc)));
        nqp::bindkey($result, 'free_str', nqp::unbox_i(1));
    }
    elsif $type ~~ Callable {
        nqp::bindkey($result, 'type', nqp::unbox_s(type_code_for($p.type)));
        my $info := param_list_for($p.sub_signature, :with-typeobj);
        nqp::unshift($info, return_hash_for($p.sub_signature));
        nqp::bindkey($result, 'callback_args', $info);
    }
    else {
        nqp::bindkey($result, 'type', nqp::unbox_s(type_code_for($p.type)));
    }
    $result
}

# Builds the list of parameter information for a callback argument.
sub param_list_for(Signature $sig, :$with-typeobj) {
    my Mu $arg_info := nqp::list();
    for $sig.params -> $p {
        nqp::push($arg_info, param_hash_for($p, :with-typeobj($with-typeobj)))
    }

    $arg_info;
}

# Builds a hash of type information for the specified return type.
sub return_hash_for(Signature $s) {
    my Mu $result := nqp::hash();
    my $returns := $s.returns;
    if $returns ~~ Str {
        my $enc := &r.?native_call_encoded() || 'utf8';
        nqp::bindkey($result, 'type', nqp::unbox_s(string_encoding_to_nci_type($enc)));
        nqp::bindkey($result, 'free_str', nqp::unbox_i(0));
    }
    # TODO: If we ever want to handle function pointers returned from C, this
    # bit of code needs to handle that.
    else {
        nqp::bindkey($result, 'type',
            $returns =:= Mu ?? 'void' !! nqp::unbox_s(type_code_for($returns)));
    }
    $result
}

# Gets the NCI type code to use based on a given Perl 6 type.
my %type_map =
    'int8'     => 'char',
    'int16'    => 'short',
    'int32'    => 'int',
    'int'      => 'long',
    'Int'      => 'longlong',
    'num32'    => 'float',
    'num64'    => 'double',
    'num'      => 'double',
    'Num'      => 'double',
    'Callable' => 'callback';
sub type_code_for(Mu ::T) {
    return %type_map{T.^name}
        if %type_map.exists(T.^name);
    return 'cstruct'
        if T.REPR eq 'CStruct';
    return 'cpointer'
        if T.REPR eq 'CPointer';
    return 'carray'
        if T.REPR eq 'CArray';
    die "Unknown type {T.^name} used in native call.\n" ~
        "If you want to pass a struct, be sure to use the CStruct representation.\n" ~
        "If you want to pass an array, be sure to use the CArray type.";
}

multi sub map_return_type(Mu $type) { Mu }
multi sub map_return_type($type) {
    $type === int8 || $type === int16 || $type === int32 || $type === int ?? Int !!
    $type === num32 || $type === num64 || $type === num                   ?? Num !!
                                                                             $type
}

my role NativeCallSymbol[Str $name] {
    method native_symbol()  { $name }
}

# This role is mixed in to any routine that is marked as being a
# native call.
my role Native[Routine $r, Str $libname] {
    has int $!setup;
    has native_callsite $!call is box_target;
    
    method postcircumfix:<( )>($args) {
        unless $!setup {
            my Mu $arg_info := param_list_for($r.signature);
            my str $conv = self.?native_call_convention || '';
            my $realname = 
                !$libname.DEFINITE   ?? "" !!
                $libname ~~ /\.\w+$/ ?? $libname !!
                                        "$libname$*VM<config><load_ext>";
            nqp::buildnativecall(self,
                nqp::unbox_s($realname),    # library name
                nqp::unbox_s(self.?native_symbol // $r.name),      # symbol to call
                nqp::unbox_s($conv),        # calling convention
                $arg_info,
                return_hash_for($r.signature));
            $!setup = 1;
        }
        nqp::nativecall(nqp::p6decont(map_return_type($r.returns)), self,
            nqp::getattr(nqp::p6decont($args), Capture, '$!list'))
    }
}

# Role for carrying extra calling convention information.
my role NativeCallingConvention[$name] {
    method native_call_convention() { $name };
}

# Role for carrying extra string encoding information.
my role NativeCallEncoded[$name] {
    method native_call_encoded() { $name };
}

# Expose an OpaquePointer class for working with raw pointers.
my class OpaquePointer is export is repr('CPointer') { }

# CArray class, used to represent C arrays.
my class CArray is export is repr('CArray') {
    method at_pos(CArray:D: $pos) { die "CArray cannot be used without a type" }
    
    my role IntTypedCArray[::TValue] does Positional[TValue] {
        multi method at_pos(::?CLASS:D \$arr: $pos) is rw {
            Proxy.new:
                FETCH => method () {
                    nqp::p6box_i(nqp::r_atpos_i($arr, nqp::unbox_i($pos.Int)))
                },
                STORE => method (int $v) {
                    nqp::r_bindpos_i($arr, nqp::unbox_i($pos.Int), $v);
                    self
                }
        }
        multi method at_pos(::?CLASS:D \$arr: int $pos) is rw {
            Proxy.new:
                FETCH => method () {
                    nqp::p6box_i(nqp::r_atpos_i($arr, $pos))
                },
                STORE => method (int $v) {
                    nqp::r_bindpos_i($arr, $pos, $v);
                    self
                }
        }
    }
    multi method PARAMETERIZE_TYPE(Int:U $t) {
        self but IntTypedCArray[$t.WHAT]
    }
    
    my role NumTypedCArray[::TValue] does Positional[TValue] {
        multi method at_pos(::?CLASS:D \$arr: $pos) is rw {
            Proxy.new:
                FETCH => method () {
                    nqp::p6box_n(nqp::r_atpos_n($arr, nqp::unbox_i($pos.Int)))
                },
                STORE => method (num $v) {
                    nqp::r_bindpos_n($arr, nqp::unbox_i($pos.Int), $v);
                    self
                }
        }
        multi method at_pos(::?CLASS:D \$arr: int $pos) is rw {
            Proxy.new:
                FETCH => method () {
                    nqp::p6box_n(nqp::r_atpos_n($arr, $pos))
                },
                STORE => method (num $v) {
                    nqp::r_bindpos_n($arr, $pos, $v);
                    self
                }
        }
    }
    multi method PARAMETERIZE_TYPE(Num:U $t) {
        self but NumTypedCArray[$t.WHAT]
    }
    
    my role TypedCArray[::TValue] does Positional[TValue] {
        multi method at_pos(::?CLASS:D \$arr: $pos) is rw {
            Proxy.new:
                FETCH => method () {
                    nqp::r_atpos($arr, nqp::unbox_i($pos.Int))
                },
                STORE => method ($v) {
                    nqp::r_bindpos($arr, nqp::unbox_i($pos.Int), nqp::p6decont($v));
                    self
                }
        }
        multi method at_pos(::?CLASS:D \$arr: int $pos) is rw {
            Proxy.new:
                FETCH => method () {
                    nqp::r_atpos($arr, $pos)
                },
                STORE => method ($v) {
                    nqp::r_bindpos($arr, $pos, nqp::p6decont($v));
                    self
                }
        }
    }
    multi method PARAMETERIZE_TYPE(Mu:U $t) {
        die "A C array can only hold integers, numbers, strings, CStructs, CPointers or CArrays (not $t.perl())"
            unless $t === Str || $t.REPR eq 'CStruct' | 'CPointer' | 'CArray';
        self but TypedCArray[$t.WHAT]
    }
}

multi trait_mod:<is>(Routine $r, :$symbol!) is export {
    $r does NativeCallSymbol[$symbol];
}

# Specifies that the routine is actually a native call, into the
# current executable (platform specific) or into a named library
multi trait_mod:<is>(Routine $r, :$native!) is export {
    $r does Native[$r, $native === True ?? Str !! $native];
}

# Specifies the calling convention to use for a native call.
multi trait_mod:<is>(Routine $r, :$nativeconv!) is export {
    $r does NativeCallingConvention[$nativeconv];
}

# Ways to specify how to marshall strings.
multi trait_mod:<is>(Parameter $p, :$encoded!) is export {
    $p does NativeCallEncoded[$encoded];
}
multi trait_mod:<is>(Routine $p, :$encoded!) is export {
    $p does NativeCallEncoded[$encoded];
}

class CStr is repr('CStr') {
    my role Encoding[$encoding] {
        method encoding() { $encoding }
    }

    multi method PARAMETERIZE_TYPE(Str:D $encoding) {
        die "Unknown string encoding for native call: $encoding" if not $encoding eq any('utf8', 'utf16', 'ascii');
        self but Encoding[$encoding];
    }
}

role ExplicitlyManagedString {
    has CStr $.cstr is rw;
}

multi explicitly-manage(Str $x is rw, :$encoding = 'utf8') is export {
    $x does ExplicitlyManagedString;
    $x.cstr = pir::repr_box_str__PsP(nqp::unbox_s($x), CStr[$encoding]);
}

#multi refresh($obj) is export {
#    nqp::nativecallrefresh($obj);
#    1;
#}

# vim:ft=perl6
