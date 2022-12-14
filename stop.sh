#!/bin/bash
docker-compose stop &
wait $!
cd apache
docker-compose stop &
wait $!
cd ..
cd tomcat
docker-compose stop
cd ..
