
# CONGRESS_START=108; # 2003
# CONGRESS_END=114;  # 2016

CONGRESS_START=115; # 2017
CONGRESS_END=115;  # 2017

dbPasswd=$1;

for congress in $(seq -f "%03g" $CONGRESS_START $CONGRESS_END); do
    echo congress=${congress} ;

    for sessionInt in 1 2; do

    echo session=${sessionInt}
    bash -f ./rollCall.sh ${congress}  ${sessionInt} ${dbPasswd} ;

    done
    
done