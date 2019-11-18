#!/usr/bin/env bash

(
    # -------------------
#---# Run Docker commands
    # -------------------

    if [[ -z $1 ]]; then
        echo -e "\n------------------------"
        echo "Service name is missing!"
        echo -e "------------------------\n"
        exit 1
    fi

    docker exec -it $1 sh
)
