# How to use the local Docker environment


## Installation

1) Install Docker Engine **>= v19.03.4** *(and Compose >= v1.24.1)*.
2) Copy and rename `.env.example` to `.env`.
3) Change the paths in `.env` from **PATH_KEYCLOAK**, **PATH_BACKEND**, **PATH_GATEWAY** and **PATH_NODE** to your local directories.

### Windows

4) Set `WINDOWS_ENVIRONMENT=true` in the `.env` file.
5) Open cmd and run `set COMPOSE_CONVERT_WINDOWS_PATHS=1`.
6) Restart Docker for Windows.
7) Go to Docker for Windows: Settings > Shared Drives > Reset credentials > Select drive "C" > Apply.


## Scripts

We have small helper scripts in the `scripts` folder, to run automatically the correct commands for needed tasks.
Just switch to the `scripts` folder or run the command as `./scripts/xxx.sh` 

**For Windows use `*.cmd` instead of `*.sh`.**


## Default start

Start runs by default the docker-compose **up** command and creates 4 services/containers:
- keycloak
- backend
- gateway
- node

Run start:
```bash
./start.sh
```


## Custom commands

### Build

Build new images for all or for a defined service.

Build all images for all services:
```bash
./build.sh
```

Build a new image just for the **gateway** service:
```bash
# build.sh [SERVICE]
# e.q.:

./build.sh gateway
```

Disable the cache for the builds:
```bash
# build.sh [OPTIONS] [SERVICE]
# e.q.:

./build.sh --no-cache
./build.sh --no-cache gateway
```

### Connect

Connect to a running container:
```bash
# connect.sh [CONTAINER]
# e.q.:

./connect.sh gateway
```

### Down

Stop all services, delete all containers and also all created volumes of the services:
```bash
./down.sh
```

### Log

Attach to Docker's stdout log for the service. The last 10 lines of the end of the logs are shown.

```bash
# log.sh [SERVICE]
# e.q.:

./log.sh node
```

### Run

Start a single service instance of the defined service and execute the shell command by default, or execute a custom command.  
If the **keycloak** service is not running, you will not have access to the public ports.

```bash
# run.sh [SERVICE] [ARG]
# e.q.:

./run.sh gateway
./run.sh gateway ls
```

### Start

You can run **start** also for a special service.  
Because of the network structure, the keycloak container will be start at all the time. He is needed to export/access the public ports.

This command for example, starts only the **keycloak** and the **node** container:
```bash
# start.sh [SERVICE]
# e.q.:

./start.sh node
```

Start **keycloak** and **node** in detached mode:
```bash
# start.sh [OPTIONS] [SERVICE]
# e.q.:

./start.sh -d node
```

### Stop

Stop all or a defined service:
```bash
# stop.sh [SERVICE]
# e.q.:

./stop.sh
./stop.sh gateway
```


## Folders

For a better performance, some folders are not mounted to the host system. These are:

- ./node
- ./node_modules
- ./target

### Synchronise

You can synchronise the `./node_modules` and `./target` folders with this commands in the running container:
```bash
syncNodeModules
syncTarget
```

To send only the current files from the container to your host, use the `force` option:
```bash
syncNodeModules force
```

### Copy

You can copy faster the folder content from the container to the host with the copy script:

```bash
# copy.sh [folder] [container]
# e.g.:

./copy.sh nodeModules
./copy.sh target

./copy.sh nodeModules gateway
```

`copy.sh nodeModules` will use the `node` container as default source.  
`copy.sh target` will use the `gateway` container as default source.

**The copy script stops the container when it is running, copy the data and restart finally the container.**
