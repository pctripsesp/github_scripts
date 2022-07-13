#!/bin/bash

## ./get_repositories.sh /home/teddy/usernames.txt 2>/dev/null
# You want to login to increase api request limit
#export GITHUB_USER=<USERNAME>
#export GITHUB_PASSWORD=<PASSWORD>

for USERNAME in `cat $1`; do

    # GET RAW JSON DATA
    json=$(curl -X GET -u $GITHUB_USER:$GITHUB_PASSWORD https://api.github.com/users/$USERNAME/repos)

    # GET NUMBER OF REPOS
    n=$(echo "$json" | jq -r '. | length')
    n=$((n-1))

    # GET REPO NAME
    for i in $( seq 0 $n )
        do
            url_repo=$(echo "$json" | jq -r .[$i].html_url)
            # PRINT ALL REPOS
            git_ext=".git"
            echo "$url_repo$git_ext" 
        done
done
