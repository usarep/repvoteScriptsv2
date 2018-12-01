use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);
# use Net::OpenSSH ;
# use Net::SCP::Expect ;
use TryCatch;
use POSIX;


# Loads all important LWP classes, and makes
# sure your version is reasonably recent.
use LWP 5.64; 

require 'saveBioGuideStatus.pl' ;

# my ($bioGuideId, $outDir);

# if ($#ARGV < 1) {
#     say "arg count is $#ARGV";
# 	die "Usage:  bioGuideId, outDir" ;
# } else {
# 	$bioGuideId = $ARGV[0];
#     $outDir = $ARGV[1];
# }

# say "calling fetchPhoto" ;
# fetchPhoto($bioGuideId, $outDir);

# say "end of fetchPhoto";

sub fetchPhoto() {

    # url format: http://bioguide.congress.gov/bioguide/photo/E/E000215.jpg
    my ($bioGuide, $dbPasswd, $dir) = @_;

    my $firstLetter = substr($bioGuide, 0, 1);

    my $url = join('', 'http://bioguide.congress.gov/bioguide/photo/', 
        $firstLetter, '/',  $bioGuide, '.jpg');

    my $response;
    my $remoteAvailable;

    # my ($doc) ;

    try
    {
        my $browser = LWP::UserAgent->new;
        $response = $browser->get( $url );

        if (! $response->is_success) {
            say "failed to get $url -- $response->status_line";

            say "updating $bioGuide in db for failure ";

            # save success status in db

            # $dbPasswd, $bioGuide, $remoteAvailable
            
            $remoteAvailable = -1;
            updateBioGuidePhotoInfoInDb($dbPasswd, $bioGuide, $remoteAvailable );

             say "... db update done";
        }
        else {
            # save to file
            say "saving $bioGuide to file ";
            my $destFile = join('', $dir, '/', $bioGuide, '.jpg');
            open(my $fh, '>:raw', $destFile);
            print $fh  $response->decoded_content ;
            close $fh;
            say "... file saving done";

            say "updating $bioGuide in db for success ";

            # save success status in db

            # $dbPasswd, $bioGuide, $remoteAvailable

            $remoteAvailable = 1;
            updateBioGuidePhotoInfoInDb($dbPasswd, $bioGuide, $remoteAvailable );

             say "... db update done";

           
        }

        # content type may be text/html or text/xml
        # die "Hey, I was expecting HTML, not ", $response->content_type
           #  unless $response->content_type eq 'text/html';
        # or whatever content-type you're equipped to deal with

        # Otherwise, process the content
        # $doc = $response->decoded_content ;
        # print $doc ;
    }
    catch ($err) {
        say "$err";
    }

    #return ($response->decoded_content);

}

1;