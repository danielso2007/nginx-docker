#!/bin/bash
docker-compose down -v &
wait $!
cd apache
docker-compose down -v &
wait $!
cd ..
cd tomcat
docker-compose down -v
cd ..
