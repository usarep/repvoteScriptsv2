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
my $dsn ="dbi:mysql:dbname=repvote_crawl;host=$dbHost";




# params: congress, sessionInt, chamberId, lastRollCall, dbPasswd
sub updateBioGuidePhotoInfoInDb() {

    if (isTestDoNotWrite() ) {
        say "isTestDoNotWrite is true, not writing";
        return 0;
    } 

    # else {
       # say "isTestDoNotWrite is false, returning anyway";
       # return -1;
    # }

    # say "should not come here!";
    
    my ($dbPasswd, $bioGuide, $remoteAvailable) = @_;
     my $status = -1;

    try
    {
       

        my $dbh = DBI->connect($dsn
                            , $dbUser
                            , $dbPasswd
                            , { RaiseError => 1 } ,
        ) or die $DBI::errstr;

# if successfully downloaded
# update rep_photo set remote_available=1, downloaded=1, last_download_date=now() where bio_guide=?

# if download failed
# update rep_photo set remote_available=-1 where bio_guide=?

        my $sqlSuccess = "update rep_photo set remote_available=1, downloaded=1, last_download_date=now() where bio_guide=? ";
        my $sqlFail = "update rep_photo set remote_available=-1 where bio_guide=? ";

        my $sql;

        if ($remoteAvailable > 0) {
            $sql = $sqlSuccess;
        } else {
            $sql = $sqlFail;
        }

       
        my $pstmt = $dbh->prepare($sql);
        my $i = 1;
       
        $pstmt->bind_param( $i++, $bioGuide );
       

	    $status = $pstmt->execute();

        say "status of save for $bioGuide = $status";

        $pstmt->finish();

        $dbh->disconnect();
        
        
    } catch ($err) {
        say "$err";
    }

    return ($status);
}

1;