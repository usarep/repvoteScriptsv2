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

require 'dbSenate.pl' ;


my (  $congress, $sessionInt, $chamberId, $largestRollCall,  $dbPasswd);

# $congress, $sessionInt, $chamberId,  $largestRollCall, $dbPasswd
if ($#ARGV < 4) {
    say "arg count is $#ARGV";
	die "Usage: congress, sessionInt, chamberId, largestRollCall. dbPasswd" ;
} else {
	$congress = $ARGV[0];
	$sessionInt = $ARGV[1];
	$chamberId = $ARGV[2];
	$largestRollCall = $ARGV[3];
	$dbPasswd = $ARGV[4];
}

my ($saveStatus) = &saveLastRollCall2Db($congress, $sessionInt, $chamberId, $largestRollCall, $dbPasswd);

say "$saveStatus";