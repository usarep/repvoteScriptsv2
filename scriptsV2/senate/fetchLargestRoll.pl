use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);

use TryCatch;
use POSIX;

require 'largestRoll.pl';

my ($congress, $sessionInt);

if ($#ARGV < 1) {
    say "arg count is $#ARGV";
	die "Usage:  congress, sessionInt" ;
} else {
	$congress = $ARGV[0];
    $sessionInt = $ARGV[1];
}

my $url = join('', 'https://www.senate.gov/legislative/LIS/roll_call_lists/vote_menu_'
            , $congress
            , '_'
            , $sessionInt
            , '.xml');

# my $url = 'https://www.senate.gov/legislative/LIS/roll_call_lists/vote_menu_115_1.xml';

my $result = getLargestRollNum($url);
say "$result" ;