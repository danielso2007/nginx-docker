#!/bin/bash
RED='\033[1;31m'
BLACK='\033[0;30m'
DARK_GRAY='\033[1;30m'
LIGHT_RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_GREEN='\033[1;32m'
BROWN_ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
LIGHT_BLUE='\033[1;34m'
PURPLE='\033[0;35m'
LIGHT_PURPLE='\033[1;35m'
CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GRAY='\033[0;37m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

cd apps/apache/certificado
echo -e "${BROWN_ORANGE}Criando o certificado do apache...${NC}"
./criar-certificado.sh -d apache.example.com -i 10.6.0.6 -s 123456
cd ..
cd ..
cd tomcat/certificado
echo -e "${BROWN_ORANGE}Criando a certificação do tomcat...${NC}"
./criar-certificado.sh -d tomcat.example.com -i 10.5.0.5 -s 123456
cd ..
echo -e "${BROWN_ORANGE}Subindo a aplicação do tomcat...${NC}"
docker compose up -d &
wait $!
cd ..
cd apache
echo -e "${BROWN_ORANGE}Subindo a aplicação apache...${NC}"
docker compose up -d &
wait $!
cd ..
cd ..
echo -e "${BROWN_ORANGE}Subindo o nginx...${NC}"
docker compose up -d &
wait $!
echo -e "${BROWN_ORANGE}Fim!${NC}"