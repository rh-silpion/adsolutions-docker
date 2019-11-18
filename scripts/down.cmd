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

docker-compose -p %DOCKER_PROJECT_NAME% -f ..\docker-compose.yml down -v
