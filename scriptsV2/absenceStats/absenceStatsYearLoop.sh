
YEAR_START=2016;
YEAR_END=2016;

dbPasswd=$1;

for chamberId in 1 2; do

    for year in $(seq -f "%03g" $YEAR_START $YEAR_END); do
        echo ${year} ;

        bash -f ./absenceStats.sh ${year} $chamberId ${dbPasswd} ;
    done

done