use 5.010;
use open qw(:locale);
use strict;
use utf8;
use warnings qw(all);
# use Net::OpenSSH ;
# use Net::SCP::Expect ;
use TryCatch;
use POSIX;

use XML::LibXML;

require '../shared/webUtil.pl';




# example of how to use: http://grantm.github.io/perl-libxml-by-example/basics.html

sub getLargestRollNum {

    my($url) = @_;

    my $largestRollNum = 0;

    try {

        my $docStr = &fetchUrl($url);

        my $dom = XML::LibXML->load_xml(string => $docStr);

        foreach my $voteNumber ($dom->findnodes('/vote_summary/votes/vote/vote_number')) {
            my $thisNumber= $voteNumber->to_literal() + 0;

            if ($thisNumber > $largestRollNum ) {
               $largestRollNum  = $thisNumber;
            }
        }

    } catch ($err) {
        say "$err";
    }

    return ($largestRollNum);

}

1;