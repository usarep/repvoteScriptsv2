
CONGRESS_START=108; # 2003
CONGRESS_END=114;  # 2016

dbPasswd=$1;

for congress in $(seq -f "%03g" $CONGRESS_START $CONGRESS_END); do
    echo ${congress} ;

    for sessionInt in 1 2; do

        bash -f ./rollCall.sh ${congress}  ${sessionInt} ${dbPasswd} ;

    done
    
done