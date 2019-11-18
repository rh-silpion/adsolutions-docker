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

    docker-compose -p ${DOCKER_PROJECT_NAME} -f ${dir}/docker-compose.yml down -v
)
