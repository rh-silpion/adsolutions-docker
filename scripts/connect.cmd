@echo off

@REM ---------------------
@REM - Run Docker commands
@REM ---------------------

IF "%1%" == "" (
    echo "Service name is missing!"
    exit
)

docker exec -it %1 sh
