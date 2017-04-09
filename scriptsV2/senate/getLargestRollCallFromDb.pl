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

my ( $congress, $sessionInt, $chamberId,  $dbPasswd );

# $congress, $sessionInt, $chamberId,  $dbPasswd
if ($#ARGV < 3) {
    say "arg count is $#ARGV";
	die "Usage: congress, sessionInt, chamberId, dbPasswd" ;
} else {
	$congress = $ARGV[0];
	$sessionInt = $ARGV[1];
	$chamberId = $ARGV[2];
	$dbPasswd = $ARGV[3];
}

my ($id, $lastRollCall) = &lastRollCallInDb($congress, $sessionInt, $chamberId, $dbPasswd);

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