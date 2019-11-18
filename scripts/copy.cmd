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

IF "%1%" == "nodeModules" (
    IF "%2%" == "" (
        SET service=node
    ) ELSE (
        SET service=%2
    )

    SET command=!service!:/app/node_modules !PATH_NODE!

    echo Delete old data ...
    FOR /D %%p IN ("!PATH_NODE!\node_modules\*.*") DO rmdir "%%p" /s /q
    echo Done.
) ELSE (
    IF "%1%" == "target" (
        IF "%2%" == "" (
            SET service=gateway
        ) ELSE (
            SET service=%2
        )

        SET command=!service!:/app/target !PATH_GATEWAY!

        echo Delete old data ...
        FOR /D %%p IN ("!PATH_GATEWAY!\target\*.*") DO rmdir "%%p" /s /q
        echo Done.
    ) ELSE (
        echo Wrong option parameter^^!
        exit
    )
)

FOR /F %%i in ('"(docker ps -f name=%service% -q)"') DO SET activeService=%%i

IF NOT "%activeService%" == "" (
    SET restart=true
    echo Stop service: "%service%"
    docker-compose -p %DOCKER_PROJECT_NAME% -f ..\docker-compose.yml stop %service%
)

echo Start copy data ...
docker cp -L %command%
echo Done.

IF "%restart%" == "true" (
    echo Start service: "%service%"
    docker-compose -p %DOCKER_PROJECT_NAME% -f ..\docker-compose.yml start %service%
)
