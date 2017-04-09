#! /usr/bin/perl
use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);
# use Net::OpenSSH ;
# use Net::SCP::Expect ;
use TryCatch;
use POSIX;
use DBI;

require 'dbHouse.pl' ;

my (  $year, $chamberId, $largestRollCall,  $dbPasswd);

# $year, $chamberId,  $largestRollCall, $dbPasswd
if ($#ARGV < 3) {
    say "arg count is $#ARGV";
	die "Usage: year, chamberId, largestRollCall. dbPasswd" ;
} else {
	$year = $ARGV[0];
	$chamberId = $ARGV[1];
	$largestRollCall = $ARGV[2];
	$dbPasswd = $ARGV[3];
}

my ($saveStatus) = &saveLastRollCall2Db($year, $chamberId, $largestRollCall, $dbPasswd);

say "$saveStatus";