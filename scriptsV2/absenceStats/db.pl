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

my $dbHost='localhost';
my $dbUser = 'repvote';
my $dsn ="dbi:mysql:dbname=repvote_crawl;host=$dbHost";


# params: year,  chamberId, dbPasswd
sub fetchVoteData {
    
    my ($year,$chamberId, $dbPasswd) = @_;

    my $rollCallNum = -1;
    my %yesNameIds = ();
    my %noNameIds = ();
    my %presentNameIds = ();
    my %absentNameIds = ();

    my $count = 0;
    try
    {
       

        my $dbh = DBI->connect($dsn
                            , $dbUser
                            , $dbPasswd
                            , { RaiseError => 1 } ,
        ) or die $DBI::errstr;

        my $sql = "select roll_call_num, csv_yes_name_ids, csv_no_name_ids, csv_present_name_ids, csv_absent_name_ids from vote_meta_data where year=? and chamber_id=? ";


        my $pstmt = $dbh->prepare($sql);
        my $i = 1;
        $pstmt->bind_param( $i++, $year );
         $pstmt->bind_param( $i++, $chamberId );

	    $pstmt->execute();

       
        while (my @row = $pstmt->fetchrow_array) {
             my $j=0;

            $rollCallNum = $row[$j++];
           
            $yesNameIds{$rollCallNum} = $row[$j++] || -1;
            $noNameIds{$rollCallNum} = $row[$j++] || -1;
            $presentNameIds{$rollCallNum} = $row[$j++] || -1;
            $absentNameIds{$rollCallNum} = $row[$j++] || -1;
          
            $count++;

           
           # say "($year, $chamberId, $lastRollCall)";
 

        }  # while

       # $pstmt2->finish();

        $pstmt->finish();

        $dbh->disconnect();
        
        
    } catch ($err) {
        say "$err";
    }

    say "count = $count";
    return ( \%yesNameIds, \%noNameIds, \%presentNameIds, \%absentNameIds);
}



1;