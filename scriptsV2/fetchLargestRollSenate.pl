use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);

use TryCatch;
use POSIX;

require 'largestRollSenate.pl';

my $url = 'https://www.senate.gov/legislative/LIS/roll_call_lists/vote_menu_115_1.xml';

my $result = getLargestRollNumSenate($url);
say "result = $result" ;