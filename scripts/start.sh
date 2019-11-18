#!/usr/bin/env bash

(
    # -------
#---# Globals
    # -------

    source "${BASH_SOURCE%/*}/_shared.sh"
    dir=$(projectDirectory)
    { loadENV; }
    keycloakName=keycloak



    # -------------------
#---# Run Docker commands
    # -------------------

    # Stop current running Docker container
    # Run "docker-compose stop" only if the container is running.
    # -----------------------------------------------------------
    #if [[ -n $(docker ps -f name=${keycloakName} -q) ]]; then
    #     ${dir}/scripts/stop.sh
    #fi

    # Remove old keycloak container from other project configuration
    # --------------------------------------------------------------
    #if [[ -n $(docker ps -a -f name=$keycloakName -q) ]] &&
    #   [[ -z $(docker ps -a -f label=com.docker.compose.project=${DOCKER_PROJECT_NAME,,} -q) ]]; then
    #    echo -e "\n-----------------------------"
    #    echo "Remove old keycloak container"
    #    echo -e "-----------------------------\n"
    #
    #    docker container stop $keycloakName &&
    #    docker container rm $keycloakName
    #fi

    # Start Docker container
    # ----------------------
    docker-compose -p ${DOCKER_PROJECT_NAME} -f ${dir}/docker-compose.yml up $@
)
