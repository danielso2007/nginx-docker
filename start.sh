#!/bin/bash
cd apache
docker-compose up -d &
wait $!
cd ..
cd tomcat
docker-compose up -d &
wait $!
cd ..
docker-compose up -d &
