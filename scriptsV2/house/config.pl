#! /usr/bin/perl
use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);

use Config::Simple;


my $cfg = new Config::Simple('app.cfg');
# $cfg->import_names();

# say "IS_TEST_DO_NOT_WRITE is  $IS_TEST_DO_NOT_WRITE" ;

sub isTestDoNotWrite() {
    my $IS_TEST_DO_NOT_WRITE = $cfg->param('IS_TEST_DO_NOT_WRITE') ;
    return $IS_TEST_DO_NOT_WRITE > 0;
}