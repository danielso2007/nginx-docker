#!/bin/bash
docker compose down -v &
wait $!
cd apps/apache
docker compose down -v &
wait $!
cd ..
cd ..
cd apps/tomcat
docker compose down -v
cd ..
cd ..
