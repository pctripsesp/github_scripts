#!/bin/bash

## ./get_log_time.sh /tmp/repositories.txt 2>/dev/null


for REPO in `cat $1`; do

    # DOWNLOAD REPO
    git clone $REPO
    
    USERNAME=$(echo $REPO | cut -d/ -f4)
    folderName=$(echo $REPO | cut -d/ -f5- | cut -d. -f1)
    cd $folderName*

    # GET LOGS
    filename='/tmp/OUTPUT.txt'
    echo $REPO >> $filename
    git log |grep -A1 $USERNAME |grep 'Date' >> $filename

    # RM repositories
    cd ..
    rm -rf $folderName* 
done
