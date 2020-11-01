
# YEAR_START=2003;
# YEAR_END=2016;

YEAR_START=2020;
YEAR_END=2020;

dbPasswd=$1;

for year in $(seq -f "%03g" $YEAR_START $YEAR_END); do
    echo ${year} ;

    bash -f ./rollCall.sh ${year} ${dbPasswd} ;
done
