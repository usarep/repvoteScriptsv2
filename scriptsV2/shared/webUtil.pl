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

# usage: &fetchUrl($url)

sub fetchUrl() {

    my ($url) = @_;

    my ($response);
    # my ($doc) ;

    try
    {
        my $browser = LWP::UserAgent->new;
        $response = $browser->get( $url );

        die "Can't get $url -- ", $response->status_line
            unless $response->is_success;

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

    return ($response->decoded_content);

}

1;