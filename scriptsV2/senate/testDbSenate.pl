use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);

require 'dbSenate.pl' ;

 my ($congress, $sessionInt, $chamberId, $lastRollCall, $dbPasswd) = (200,1,2,200,'repvote123');

 saveLastRollCall2Db($congress, $sessionInt, $chamberId, $lastRollCall, $dbPasswd);

 say "done";