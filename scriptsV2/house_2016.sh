
# crawl house roll call data for a given year.

# for format of a roll call vote, US House of Representatives, see
# http://clerk.house.gov/evs/2014/roll480.xml

pre=https://clerk.house.gov/evs

dest=data/house.data ;

# 2016
year=2016
START=1
END=622


# see http://stackoverflow.com/questions/8789729/zero-padding-in-bash
# also http://stackoverflow.com/questions/169511/how-do-i-iterate-over-a-range-of-numbers-defined-by-variables-in-bash

mkdir -p ${preDir}/${year}

for i in $(seq -f "%03g" $START $END); do
 echo ${pre}/${year}/roll${i}.xml ;
 file=roll${i}.xml ;
 curl -o ${dest}/${year}/${file}  ${pre}/${year}/${file} ;
done