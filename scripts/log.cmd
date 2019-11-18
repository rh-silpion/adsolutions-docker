@echo off

@REM ---------------------
@REM - Run Docker commands
@REM ---------------------

IF "%1%" == "" (
    echo "Service name is missing!"
    exit
)

docker logs --tail=10 -f $1
