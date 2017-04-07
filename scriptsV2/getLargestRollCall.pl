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

require 'dbUtil.pl' ;

my (  $year, $chamberId,  $dbPasswd);

# $year, $chamberId,  $dbPasswd
if ($#ARGV < 2) {
    say "arg count is $#ARGV";
	die "Usage: year, chamberId, dbPasswd" ;
} else {
	$year = $ARGV[0];
	$chamberId = $ARGV[1];
	$dbPasswd = $ARGV[2];
}

my ($id, $lastRollCall) = &lastRollCallFetched($year, $chamberId, $dbPasswd);

my $result;
if ($lastRollCall < 0) {
	$result = 1;
} 
else {
	$result = $lastRollCall + 1;
}  
say $result;

# say "(id, lastRollCall) for (2017, 2) = ($id, $lastRollCall) " ;

# my ($saveStatus) = &saveLastRollCallFetched(2017,2, 101, $dbPasswd);

#say "from caller: saveStatus = $saveStatus";