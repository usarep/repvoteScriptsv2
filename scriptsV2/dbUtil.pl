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
my $dsn ="dbi:mysql:dbname=rep_crawl_status;host=$dbHost";


# params: year, chamberId, dbPasswd
sub lastRollCallFetched() {
    
    my ($year, $chamberId, $dbPasswd) = @_;

    my $id = -1;
    my $lastRollCall = -1;

    try
    {
       

        my $dbh = DBI->connect($dsn
                            , $dbUser
                            , $dbPasswd
                            , { RaiseError => 1 } ,
        ) or die $DBI::errstr;

        my $sql = "select rcs.id, rcs.last_roll_call from roll_crawl_status rcs where year=? and chamber_id=? ";

        # my $sql2 = "update roll_call_status set last_roll_call=? where year=? and chamber_id=?" ;

        # my $pstmt2 = $dbh->prepare($sql2);

        my $pstmt = $dbh->prepare($sql);
        my $i = 1;
        $pstmt->bind_param( $i++, $year );
        $pstmt->bind_param( $i++, $chamberId );

	    $pstmt->execute();

        my $count = 0;
        while (my @row = $pstmt->fetchrow_array) {
            $id = $row[0];
            $lastRollCall = $row[1] || -1;
          
            $count++;

           
           # say "($year, $chamberId, $lastRollCall)";
 

        }  # while

       # $pstmt2->finish();

        $pstmt->finish();

        $dbh->disconnect();
        
        
    } catch ($err) {
        say "$err";
    }

    return ($id, $lastRollCall);
}

# params: year, chamberId, lastRollCall, dbPasswd
sub saveLastRollCallFetched() {
    
    my ($year, $chamberId, $lastRollCall, $dbPasswd) = @_;
     my $status = -1;

    try
    {
       

        my $dbh = DBI->connect($dsn
                            , $dbUser
                            , $dbPasswd
                            , { RaiseError => 1 } ,
        ) or die $DBI::errstr;

        # my $sql = "update roll_crawl_status set last_roll_call=? where year=? and chamber_id=?" ;

        my $sql = "insert into roll_crawl_status (year, chamber_id, last_roll_call) \
            values (?,?,?) on duplicate key update last_roll_call=values(last_roll_call) " ;

       
        my $pstmt = $dbh->prepare($sql);
        my $i = 1;
       
        $pstmt->bind_param( $i++, $year );
        $pstmt->bind_param( $i++, $chamberId );
        $pstmt->bind_param( $i++, $lastRollCall );

	    $status = $pstmt->execute();

        # say "status of save = $status";

        $pstmt->finish();

        $dbh->disconnect();
        
        
    } catch ($err) {
        say "$err";
    }

    return ($status);
}

1;