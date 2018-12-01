use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);
# use Net::OpenSSH ;
# use Net::SCP::Expect ;
use TryCatch;
use POSIX;

require 'fetchBioGuides.pl' ;

require 'downloadRepPhotos.pl' ;

my $dbPasswd;
my $outDir;

if ($#ARGV < 1) {
    say "arg count is $#ARGV";
	die "Usage:  dbPasswd outDir" ;
} else {
	$dbPasswd = $ARGV[0];
    $outDir = $ARGV[1];
}

my %bioGuides = fetchBioGuideIds($dbPasswd);

my $count=0;
# say " =============== bioGuides from caller: " ;
foreach my $bioGuideId (sort keys %bioGuides) {
    
    fetchPhoto($bioGuideId, $dbPasswd, $outDir);

    # $count++;

    # if ($count < 5) {
    #     say "$bioGuideId   $bioGuides{$bioGuideId} " ;
    #     fetchPhoto($bioGuideId, $dbPasswd, $outDir);
    # } else {
    #     # no op
    # }
    
    
}