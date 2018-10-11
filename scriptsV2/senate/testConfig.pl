#! /usr/bin/perl
use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);

require 'config.pl' ;

my $isTestDoNotWriteVar = isTestDoNotWrite();

say "isTestDoNotWrite is  $isTestDoNotWriteVar" ;

