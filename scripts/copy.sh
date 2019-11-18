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

    if [[ $1 == "nodeModules" ]]; then
        service=$([[ -n "$2" ]] && echo $2 || echo "node")
        command="${service}:/app/node_modules ${PATH_NODE}"

        echo "Delete old data ..."
        rm -rf ${PATH_NODE}/node_modules/*
        echo "Done."
    elif [[ $1 == "target" ]]; then
        service=$([[ -n "$2" ]] && echo $2 || echo "gateway")
        command="${service}:/app/target ${PATH_GATEWAY}"

        echo "Delete old data ..."
        rm -rf ${PATH_GATEWAY}/target/*
        echo "Done."
    else
        echo -e "\n-----------------------"
        echo "Wrong option parameter!"
        echo -e "-----------------------\n"
        exit 1;
    fi

    if [[ -n $(docker ps -f name=${service} -q) ]]; then
        restart="true"
        echo "Stop service: \"${service}\""
        docker-compose -p ${DOCKER_PROJECT_NAME} -f ${dir}/docker-compose.yml stop ${service}
    fi

    echo "Start copy data ..."
    docker cp -L ${command}
    echo "Done."

    if [[ ${restart} == "true" ]]; then
        echo "Start service: \"${service}\""
        docker-compose -p ${DOCKER_PROJECT_NAME} -f ${dir}/docker-compose.yml start ${service}
    fi
)
