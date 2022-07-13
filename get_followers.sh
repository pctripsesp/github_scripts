#!/bin/bash

## ./get_followers.sh /tmp/usernames.txt 2>/dev/null
# You want to login to increase api request limit
#export GITHUB_USER=<USERNAME>
#export GITHUB_PASSWORD=<PASSWORD>

for USERNAME in `cat $1`; do

    # GET RAW JSON DATA
    json=$(curl -X GET -u $GITHUB_USER:$GITHUB_PASSWORD https://api.github.com/users/$USERNAME/followers)

    # GET NUMBER OF FOLLOWERS
    n=$(echo "$json" | jq -r '. | length')
    n=$((n-1))
    # GET FOLLOWER USERNAME
    for i in $( seq 0 $n )
        do
            url_repo=$(echo "$json" | jq -r .[$i].html_url)
            # PRINT ALL REPOS
            echo "$url_repo" | cut -d/ -f4- 
        done
done
