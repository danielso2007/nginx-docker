#!/bin/bash
docker compose stop &
wait $!
cd apps/apache
docker compose stop &
wait $!
cd ..
cd tomcat
docker compose stop
cd ..
cd ..