# crawl house roll call data for a given year.
# usage rollCallHouse.sh year dbPasswd

# for format of a roll call vote, US House of Representatives, see
# http://clerk.house.gov/evs/2014/roll480.xml

pre=https://clerk.house.gov/evs

dest=data/house.data ;


year=$1 ;
chamberId=1; # house == 1
dbPasswd=$2;

url='http://clerk.house.gov/evs/${year}/index.asp';

START=`perl getLargestRollCall.pl ${year} ${chamberId} ${dbPasswd}` ;
END=`perl fetchLargestRollHouse.pl ${year}` ;

echo START = ${START} ;
echo END = ${END} ;

# see http://stackoverflow.com/questions/8789729/zero-padding-in-bash
# also http://stackoverflow.com/questions/169511/how-do-i-iterate-over-a-range-of-numbers-defined-by-variables-in-bash

if (( END >= START )); then

    mkdir -p ${dest}/${year}

    for i in $(seq -f "%03g" $START $END); do
        echo ${pre}/${year}/roll${i}.xml ;
        # file=roll${i}.xml ;
        # curl -o ${dest}/${year}/${file}  ${pre}/${year}/${file} ;
    done

    # save the largest roll call
    SAVE_STATUS=`perl saveLargestRollCall.pl ${year} ${chamberId} ${END} ${dbPasswd}` ;
    echo save status = $SAVE_STATUS

else
    echo START=$START , END=$END, no fetch performed
fi