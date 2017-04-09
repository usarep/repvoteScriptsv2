
CONGRESS_START=113; 
CONGRESS_END=115; 

# dbPasswd=$1;

pre=https://www.gpo.gov/fdsys/bulkdata/BILLSTATUS ;

dest=data.repvote/bill.data ;


for congress in $(seq -f "%03g" $CONGRESS_START $CONGRESS_END); do
    echo ${congress} ;

    mkdir -p ${dest}/${congress} ;

    for docType in s sres sjres sconres hres hr hjres hconres ; do
        # example:  
        # file is BILLSTATUS-113-sconres.zip 
        # path is https://www.gpo.gov/fdsys/bulkdata/BILLSTATUS/113/sconres
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