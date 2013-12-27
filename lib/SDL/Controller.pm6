
module SDL::Controller;

use NativeCall;
#use SDL; # I cant do that?
use SDL::Event;

class SDL::Controller {
	has @!show_handlers;
	has @!event_handlers;
	has Bool $!stop = False;

	method add_show_handler( Code $handler ) {
		@!show_handlers.push( $handler )
	}

	method add_event_handler( Code $handler ) {
		@!event_handlers.push( $handler )
	}

	method stop {
		$!stop = True
	}

	method run {
		#my $dt     = $_dt{$ref};
		#my $delay  = $_delay{$ref};

		# these should never change
		#my $event_handlers = $_event_handlers{$ref};
		#my $move_handlers  = $_move_handlers{$ref};
		#my $show_handlers  = $_show_handlers{$ref};

		# alows us to do stop and run
		#delete $_stop{$ref};
		#delete $_paused{$ref};

		#my $current_time = Time::HiRes::time;
		#Time::HiRes::sleep($delay) if $delay;
		my $count = 0;
		my $event = SDL::Event.new;

		while !$!stop {
			#my $new_time   = Time::HiRes::time;
			#my $delta_time = $new_time - $current_time;
			#if ( $delta_time < $_min_t{$ref} ) {
			#	Time::HiRes::sleep(0.001); # sleep at least a millisecond
			#	redo;
			#}
			#$current_time = $new_time;
			#$delta_time = $_max_t{$ref} if $delta_time > $_max_t{$ref};
			#my $delta_copy = $delta_time;
			#my $time_ref   = \$_time{$ref};

			_pump_events;
			while ( $event.poll ) {
				#$stop_handler->( $event, $self ) if $stop_handler;
				.( $event ) for @!event_handlers;
				#$event.dump
			}

			#while ( $delta_copy > $dt ) {
			#	$self->_move( $move_handlers, 1, $$time_ref ); # a full move
			#	$delta_copy -= $dt;
			#	$$time_ref += $dt;
			#}
			#my $step = $delta_copy / $dt;
			#$self->_move( $move_handlers, $step, $$time_ref ); # a partial move
			#$$time_ref += $dt * $step;

			.() for @!show_handlers;

			#Time::HiRes::sleep($delay) if $delay;

			# these can change during the cycle
			#$dt    = $_dt{$ref};
			#$delay = $_delay{$ref};
			_delay( 20 );
		}
	}
}

our sub _pump_events( )  returns Int  is native('libSDL')  is symbol('SDL_PumpEvents')  { * }
our sub _delay( int32 )               is native('libSDL')  is symbol('SDL_Delay')       { * }
