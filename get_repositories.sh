#!/bin/bash

## ./get_github.sh /home/eddy/github_usernames.txt 2>/dev/null

for USERNAME in `cat $1`; do

    # GET RAW JSON DATA
    json=$(curl https://api.github.com/users/$USERNAME/repos)

    # GET NUMBER OF REPOS
    n=$(echo "$json" | jq -r '. | length')
    n=$((n-1))
    
    # GET REPO NAME
    for i in $( seq 1 $n )
        do
            url_repo=$(echo "$json" | jq -r .[$i].html_url)
            # PRINT ALL REPOS
            git_ext=".git"
            echo "$url_repo$git_ext" 
        done
done
