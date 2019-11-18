#!/usr/bin/env sh

alias ll='ls -laFh'

alias runwar='(cd /app/target \
    && java -Xmx2048m -Xms1024m -jar toolbox-0.0.1-SNAPSHOT.war)'

alias buildProd='(cd /app \
    && rm -rf /app/target/* \
    && ./mvnw -ntp verify -Pprod -DskipTests)'

alias buildFull='(cd /app \
    && ./mvnw -ntp -Dapplication.hazelcast.port-auto-increment=true verify \
    && ./mvnw -ntp com.github.eirslett:frontend-maven-plugin:yarn -Dfrontend.yarn.arguments="run test" \
    && rm -rf /app/target/* \
    && ./mvnw -ntp verify -Pprod -DskipTests)'
