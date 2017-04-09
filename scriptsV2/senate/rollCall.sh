# crawl senate roll call data for a given year.
# usage rollCallSenate.sh year dbPasswd

# for format of a roll call vote, US House of Representatives, see
# https://www.senate.gov/legislative/LIS/roll_call_votes/vote1141/vote_114_1_00220.xml

pre=https://www.senate.gov/legislative/LIS/roll_call_votes/vote

dest=data.repvote/senate.data ;


congress=$1 ;
sessionInt=$2 ;
chamberId=2; # senate == 2
dbPasswd=$3;

year=$(( 1787 + ${congress} * 2 + $sessionInt/2 )) ;
echo year=$year;



START=`perl getLargestRollCallFromDb.pl ${congress} ${sessionInt} ${chamberId} ${dbPasswd}` ;
END=`perl fetchLargestRoll.pl ${congress} ${sessionInt}` ;

echo START = ${START} ;
echo END = ${END} ;

# see http://stackoverflow.com/questions/8789729/zero-padding-in-bash
# also http://stackoverflow.com/questions/169511/how-do-i-iterate-over-a-range-of-numbers-defined-by-variables-in-bash

if (( END >= START )); then

    mkdir -p ${dest}/${year}

    for i in $(seq -f "%05g" $START $END); do
        firstPart=${pre}${congress}${sessionInt} ;
        file=vote_${congress}_${sessionInt}_${i}.xml ;
        echo ${firstPart}/${file} ;
        curl -o ${dest}/${year}/${file}  ${firstPart}/${file} ;

    done

    # save the largest roll call
    SAVE_STATUS=`perl saveLargestRollCall2Db.pl ${congress} ${sessionInt} ${chamberId} ${END} ${dbPasswd}` ;
    echo save status = $SAVE_STATUS

else
    echo START=$START , END=$END, no fetch performed
fi