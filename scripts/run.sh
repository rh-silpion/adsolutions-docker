#!/usr/bin/env bash

(
    # -------
#---# Globals
    # -------

    source "${BASH_SOURCE%/*}/_shared.sh"
    dir=$(projectDirectory)
    { loadENV; }



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


    # Get custom command or set default command
    # -----------------------------------------
    command=$([[ -n "$2" ]] && echo $2 || echo "sh")


    # Run special service with custom or default command
    # --------------------------------------------------
    docker-compose -p ${DOCKER_PROJECT_NAME} -f ${dir}/docker-compose.yml run --rm --service-ports --no-deps $1 ${command}
)
