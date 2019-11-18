@echo off

@REM -------------------
@REM - Read .env content
@REM -------------------

@setlocal enableextensions enabledelayedexpansion

FOR /F "tokens=*" %%i in ('type ..\.env') DO (
    SET str=%%i
    IF NOT "!str:~0,1!"=="#" (
        SET %%i
    )
)



@REM ---------------------
@REM - Run Docker commands
@REM ---------------------

IF "%1%" == "" (
    echo "Service name is missing!"
    exit
)

IF "%2%" == "" (
    SET COMMAND=sh
) ELSE (
    SET COMMAND=%2
)

docker-compose -p %DOCKER_PROJECT_NAME% -f ..\docker-compose.yml run --rm --service-ports --no-deps %1 %COMMAND%
