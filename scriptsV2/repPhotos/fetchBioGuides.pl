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


# params: dbPasswd
sub fetchBioGuideIds() {
    
    my ($dbPasswd) = @_;

    my $lastValue = '';
    my %bioGuides;

    try
    {
       

        my $dbh = DBI->connect($dsn
                            , $dbUser
                            , $dbPasswd
                            , { RaiseError => 1 } ,
        ) or die $DBI::errstr;

        # remote_available == 0 means not known whether photo is available. 
        # -1 means we have received a 404 before. +1 means we have the data

        my $sql = "select bio_guide from rep_photo where remote_available=0 ";

        my $pstmt = $dbh->prepare($sql);
       

	    $pstmt->execute();


        while (my @row = $pstmt->fetchrow_array) {
            $lastValue = $row[0];
            $bioGuides{ $lastValue  } = 1;
        

           
           # say "($year, $chamberId, $lastRollCall)";
 

        }  # while

        $pstmt->finish();

        $dbh->disconnect();
        
        
    } catch ($err) {
        say "$err";
    }

    return (%bioGuides);
}


1;