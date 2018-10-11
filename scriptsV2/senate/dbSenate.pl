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

require 'config.pl' ;

my $dbHost='localhost';
my $dbUser = 'repvote';
my $dsn ="dbi:mysql:dbname=rep_crawl_status;host=$dbHost";


# params: congress, sessionInt, chamberId, dbPasswd
sub lastRollCallInDb() {
    
    my ($congress, $sessionInt, $chamberId, $dbPasswd) = @_;

    my $id = -1;
    my $lastRollCall = -1;

    try
    {
       

        my $dbh = DBI->connect($dsn
                            , $dbUser
                            , $dbPasswd
                            , { RaiseError => 1 } ,
        ) or die $DBI::errstr;

        my $sql = "select rcs.id, rcs.last_roll_call from roll_crawl_status_senate rcs where congress=? and session_int=? and chamber_id=? ";

        my $pstmt = $dbh->prepare($sql);
        my $i = 1;
        $pstmt->bind_param( $i++, $congress );
        $pstmt->bind_param( $i++, $sessionInt );
        $pstmt->bind_param( $i++, $chamberId );

	    $pstmt->execute();

        my $count = 0;
        while (my @row = $pstmt->fetchrow_array) {
            $id = $row[0];
            $lastRollCall = $row[1] || -1;
          
            $count++;

           
           # say "($year, $chamberId, $lastRollCall)";
 

        }  # while

        $pstmt->finish();

        $dbh->disconnect();
        
        
    } catch ($err) {
        say "$err";
    }

    return ($id, $lastRollCall);
}

# params: congress, sessionInt, chamberId, lastRollCall, dbPasswd
sub saveLastRollCall2Db() {

    if (isTestDoNotWrite() ) {
        say "isTestDoNotWrite is true, not writing";
        return 0;
    } 

    # else {
       # say "isTestDoNotWrite is false, returning anyway";
       # return -1;
    # }

    # say "should not come here!";
    
    my ($congress, $sessionInt, $chamberId, $lastRollCall, $dbPasswd) = @_;
     my $status = -1;

    try
    {
       

        my $dbh = DBI->connect($dsn
                            , $dbUser
                            , $dbPasswd
                            , { RaiseError => 1 } ,
        ) or die $DBI::errstr;

        # my $sql = "update roll_crawl_status set last_roll_call=? where year=? and chamber_id=?" ;

        my $sql = "insert into roll_crawl_status_senate (congress, session_int, chamber_id, last_roll_call) \
            values (?,?,?,?) on duplicate key update last_roll_call=values(last_roll_call) " ;

       
        my $pstmt = $dbh->prepare($sql);
        my $i = 1;
       
        $pstmt->bind_param( $i++, $congress );
        $pstmt->bind_param( $i++, $sessionInt );
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