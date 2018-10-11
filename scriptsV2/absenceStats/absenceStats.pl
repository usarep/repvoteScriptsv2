use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);
# use Net::OpenSSH ;
# use Net::SCP::Expect ;
use TryCatch;
use POSIX;

require 'db.pl';

my $year=2016;
my $chamberId=1;

my $dbPasswd;

# $year, $chamberId,  $largestRollCall, $dbPasswd
if ($#ARGV < 0) {
    say "arg count is $#ARGV";
	die "Usage: year, chamberId, dbPasswd" ;
} else {
	# $year = $ARGV[0];
	# $chamberId = $ARGV[1];
	# $largestRollCall = $ARGV[2];
	$dbPasswd = $ARGV[0];
}



sub testHash
{
    my $status = 0;

    try {

=foo comment

returning multiple hashes from a subroutine:

http://www.perlmonks.org/?node_id=647264

You'll need to return references to your hashes from the sub, as in:
return(\%test1, \%test2);

In the caller, if you must, you can dereference the hashrefs by:

my ($test1,$test2) = &testsub;
my %test1 = %$test1;
my %test2 = %$test2;


=cut

        my ($yesNameIds, $noNameIds, $presentNameIds, $absentNameIds) 
            = fetchVoteData($year, $chamberId, $dbPasswd);
        
        say "fetchVoteData() successful, but can we read the values? ";


        my %yesNameIds = %$yesNameIds;
        my %noNameIds = %$noNameIds;
        my %presentNameIds = %$presentNameIds;
        my %absentNameIds = %$absentNameIds;

=bar comment

        say " =============== yes name ids: " ;
        foreach my $rollCall (sort keys %yesNameIds) {
            say "$rollCall   $yesNameIds{$rollCall} " ;
        }

        say " =============== no name ids: " ;
        foreach  my $rollCall2 (sort keys %noNameIds) {
            say "$rollCall2   $noNameIds{$rollCall2} " ;
        }

=cut


        $status = 1;

    } catch ($err) {
        say "$err";
    }

    return ($status);
}

my ($status) 
    = testHash($year, $chamberId, $dbPasswd);

say "status = $status" ;