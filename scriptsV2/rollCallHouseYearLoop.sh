
YEAR_START=2003;
YEAR_END=2016;

dbPasswd=$1;

for year in $(seq -f "%03g" $YEAR_START $YEAR_END); do
    echo ${year} ;

    bash -f ./rollCallHouse.sh ${year} ${dbPasswd} ;
done