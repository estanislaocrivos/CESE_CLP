#! /usr/local/ActivePerl-5.6/bin/perl

$0 =~ /[\w\.]+$/ and $script_name = $&;

$filename = $ARGV[0] or ( $filename = (glob "*.vhd")[0] );
$filename or die "Please specify a VHDL filename\n\n  $script_name filename\n\n";
open( VHDL_FILE, $filename ) or die "Can't open $filename\n  $!\n";
while( <VHDL_FILE> ) {
  s/^(("[^"]*"|[^"]|'"')*?)--.*/$1/g; # remove comments
  $file_contents .= $_;
}

# Find the clock signal
# look for "rising_edge(..)" or "falling_edge(..)"
$clock_signal = 'not found';
if( $file_contents =~ /(rising|falling)_edge\s*\(\s*(\w+)/i ) {
  $clock_signal = $2;
  $clock_process = "
  clocking: process
  begin
    while not stop_the_clock loop
      $clock_signal <= '0';
      wait for 5 ns;
      $clock_signal <= '1';
      wait for 5 ns;
    end loop;
    wait;
  end process;";
}

# Find the reset signal
# look for template matching:
#    if Reset = '1' then
#      Cnt <= "00000000";
#    elsif Rising_edge(Clock) then
$reset_signal = "not found";
if( $file_contents =~ /if\s+(\w+)\s*=\s*'([01])'\s+then.*?elsif\s+(rising|falling)_edge\(/is ) {
  $reset_active = $2;
  $reset_inactive = 1 - $reset_active;
  $reset_signal = $1;
  $reset_code = "
    $reset_signal <= '$reset_active';
    wait for 5 ns;
    $reset_signal <= '$reset_inactive';
    wait for 5 ns;";
}

# Extract the first entity declaration and name
unless( $file_contents =~ /^\s*(entity\s+(\w+).*?end(\s*entity)?\s*\2?\s*;)/ims ) {
  die "Couldn't find an entity declaration in $filename\n";
}
( $entity_declaration, $entity_name ) = ( $1, $2 );

# Assemble component declaration
$component_declaration = $entity_declaration;
$component_declaration =~ s/entity.*?is/component $entity_name/i;
$component_declaration =~ s/end\s*\w*\s*\w*\s*;$/end component;/i;

# Extract port declarations, assemble port names list
# and test bench signal declarations
unless( $entity_declaration =~ /port\s*\((.*)\)\s*;/is ) { die "Couldn't find the port\n" }
foreach( split( /;\s*/, $1 ) ) {
  unless( /([^:]+):\s*(in|out|inout|buffer)\s+(.+)/i ) { die "Can't extract signals from:\n  $_\n" }
  ( $signals, $mode, $type ) = ($1, $2, $3 );
  $signal_declarations .= "  signal $signals: $type;\n";
  foreach( $signals =~ /\w+/g ) {
    $port_names .= ( $port_count++ ? ', ' : '' ) . $_;
#    if( $mode =~ /in/i ) {
#      $initialisation_assignments .= "  $_ <= ";
#      if( $type 
#    }
  }
  
  
  
}

$test_bench_entity_name = $entity_name . '_tb';
$test_bench_filename    = $entity_name . '_tb.vhd';
if( -f $test_bench_filename ) {
  print "$test_bench_filename already exists. Overwrite? (y/n): ";
  unless( <STDIN> =~ /y/i ) {
    print "Aborting\n";
    exit 0;
  }
}
open( TEST_BENCH, ">$test_bench_filename" ) or die "Can't open $test_bench_filename\n  $!\n";
print TEST_BENCH <<PRINT_TO_HERE;
-- Test bench created by $script_name
-- Copyright Doulos Ltd
-- SD, 10 May 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity $test_bench_entity_name is
end;

architecture bench of $test_bench_entity_name is

$component_declaration

$signal_declarations
  signal stop_the_clock: boolean;

begin

  uut: $entity_name port map ( $port_names );

  stimulus: process
  begin
  
    -- Put initialisation code here
$reset_code

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;
$clock_process

end;
PRINT_TO_HERE
close( TEST_BENCH );

unless( $file_contents =~ /.*architecture\s+(\w+)\s*of\s*$entity_name/is ) {
  die "Can't find an architecture\n";
}
$architecture_name = $1;

$configuration_filename = "${entity_name}_cf.vhd";
if( -f $configuration_filename ) {
  print "$configuration_filename already exists. Overwrite? (y/n): ";
  unless( <STDIN> =~ /y/i ) {
    print "Aborting\n";
    exit 0;
  }
}
open( CONFIGURATION, ">$configuration_filename" ) or die "Can't open $configuration_filename\n  $!\n";
print CONFIGURATION <<PRINT_TO_HERE;
-- Test bench configuration created by tb_gen_vhdl.pl
-- Copyright Doulos Ltd
-- SD, 10 May 2002
configuration cfg_${entity_name}_tb of ${entity_name}_tb is
  for bench
    for uut: $entity_name
      use entity work.${entity_name}($architecture_name);
    end for;
  end for;
end cfg_${entity_name}_tb;
PRINT_TO_HERE
close( CONFIGURATION );

print <<PRINT_TO_HERE;
Processed:          $filename
Found entity:       $entity_name
Found architecture: $architecture_name
Clock name:         $clock_signal
Reset name:         $reset_signal
Test bench name:    $test_bench_entity_name
Created file:       $test_bench_filename
Created file:       $configuration_filename
All done
PRINT_TO_HERE
