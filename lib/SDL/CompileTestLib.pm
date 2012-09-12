module SDL::CompileTestLib;

sub compile_test_lib( $name ) is export {
    my $o  = $*VM<config><o>;
    my $so = $*VM<config><load_ext>;
    my $c_line = "$*VM<config><cc> -c $*VM<config><cc_shared> $*VM<config><cc_o_out>$name$o $*VM<config><ccflags> $name.c";
    my $l_line = "$*VM<config><ld> $*VM<config><ld_load_flags> $*VM<config><ldflags> " ~
        "$*VM<config><libs> $*VM<config><ld_out>$name$so $name$o";
    shell($c_line);
    shell($l_line);
}
