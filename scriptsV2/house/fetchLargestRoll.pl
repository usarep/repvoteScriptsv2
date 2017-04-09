use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);

use TryCatch;
use POSIX;

require 'largestRoll.pl';

my ($year);

if ($#ARGV < 0) {
    say "arg count is $#ARGV";
	die "Usage:  year" ;
} else {
	$year = $ARGV[0];
}

my $url = join('', 'http://clerk.house.gov/evs/', $year, '/index.asp');

my $result = getLargestRollNum($url);
# say "result = $result" ;
say $result;

