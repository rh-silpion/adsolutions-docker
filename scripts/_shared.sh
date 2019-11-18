#!/usr/bin/env bash

# --------------
# Load .env file
# --------------

loadENV() {
    dir=$(projectDirectory)

    if [[ ! -f "$dir/.env" ]]; then
        echo -e "\n-----------------------" >&2
        echo "File \".env\" is missing!" >&2
        echo -e "-----------------------\n" >&2
        exit 1;
    fi

    export $(grep -v '^#' ${dir}/.env | xargs)
}



# ----------------------------
# Get correct docker directory
# ----------------------------

projectDirectory() {
    pushd `dirname $0` > /dev/null
    cd ..
    SCRIPTPATH=`pwd`
    popd > /dev/null
    echo ${SCRIPTPATH}
}
