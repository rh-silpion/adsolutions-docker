#!/usr/bin/env bash

(
    # -------------------
#---# Run Docker commands
    # -------------------

    # Check if service name exist's
    # -----------------------------
    if [[ -z "$1" ]]; then
        echo -e "\n------------------------"
        echo "Service name is missing!"
        echo -e "------------------------\n"
        exit 1;
    fi

    docker logs --tail=10 -f $1
)
