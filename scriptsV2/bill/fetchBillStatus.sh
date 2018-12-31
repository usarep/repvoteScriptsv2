
# CONGRESS_START=113; 

CONGRESS_START=115; 
CONGRESS_END=115; 

# dbPasswd=$1;

# this is for before Dec 18, 2018: 
pre=https://www.gpo.gov/fdsys/bulkdata/BILLSTATUS ;

# Dec 18: format has changed.
# needs to be re-written, see https://www.govinfo.gov/bulkdata/json/BILLSTATUS/115
# pre=https://www.govinfo.gov/bulkdata/xml/BILLSTATUS;


dest=data.repvote/bill.data ;


for congress in $(seq -f "%03g" $CONGRESS_START $CONGRESS_END); do
    echo ${congress} ;

    mkdir -p ${dest}/${congress} ;

    for docType in s sres sjres sconres hres hr hjres hconres ; do
        # example:  
        # file is BILLSTATUS-113-sconres.zip 
        # path is https://www.gpo.gov/fdsys/bulkdata/BILLSTATUS/113/sconres
        # 
        # Dec 18 2018: path changed, and so also how to fetch the data. 
        # code here will not work. no zip file available anymore. individual links
        # in a json file or an xml file
        #   https://www.govinfo.gov/bulkdata/BILLSTATUS/115
        #   XML: https://www.govinfo.gov/bulkdata/xml/BILLSTATUS/115
        #   JSON: https://www.govinfo.gov/bulkdata/json/BILLSTATUS/115
        # TODO process json directly
        # 

        path=${pre}/${congress}/${docType} ;
        file=BILLSTATUS-${congress}-${docType}.zip  ;
        echo ${path}/${file} ;
        curl -o ${dest}/${congress}/${file}  ${path}/${file} ;

        curDir=`pwd`;
        cd ${dest}/${congress};
        echo after cd `pwd` ;
        mkdir -p BILLSTATUS-${congress}-${docType} ;
        unzip -u ${file} -d BILLSTATUS-${congress}-${docType} ;
        cd ${curDir} ;

        echo back to `pwd` ;
    done
    
done