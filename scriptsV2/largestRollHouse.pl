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

use HTML::TableExtract;
use Text::Table;

require 'webUtil.pl';


sub getLargestRollNumHouse {

    my($url) = @_;

    my $largestRollNum = 0;

    try {

    
        my $docStr = &fetchUrl($url);

        my $headers =  [ 'Roll' ]; # [ 'Roll', 'Issue', 'Question' ];

        # for links, set keep_html to 1. but for our case, just the largest roll call value is sufficient
        # my $table_extract = HTML::TableExtract->new(headers => $headers, keep_html => 1);

        my $table_extract = HTML::TableExtract->new(headers => $headers);
        my $table_output = Text::Table->new(@$headers);
        
        $table_extract->parse($docStr);
        my ($table) = $table_extract->tables;
        
       
        my $count = 0;
        for my $row ($table->rows) {
            
            $table_output->load($row);
            if ($count == 0) {
                ($largestRollNum) = @$row;
            }
            $count++ ;
            # print " $count :  ", join(',', @$row), "\n";
            
        }
 
        # say "largest roll num = $largestRollNum" ;

        # print $table_output;

    } catch ($err) {
        say "$err";
    }

   

    return ($largestRollNum);

}  # getLargestRollNum

1;