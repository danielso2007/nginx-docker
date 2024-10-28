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
rm -rf *.pem
rm -rf *.jks
rm -rf *.der
rm -rf *.crt
rm -rf *.key
rm -rf *.pfx
rm -rf *.csr
rm -rf *.srl
rm -rf *.crt
rm -rf *.key

export OPENSSL_CN="localhost"
export IP_ADDRESS="127.0.0.1"
export OPENSSL_C=BR
export OPENSSL_ST=SaoPaulo
export OPENSSL_L=SaoPaulo
export OPENSSL_O=MinhaEmpresa
export OPENSSL_OU=TI
export OPENSSL_PASS=123456

# Analisando os argumentos
while getopts ":d:i:s:h" opt; do
  case $opt in
    d)
      OPENSSL_CN="$OPTARG"
      ;;
    i)
      IP_ADDRESS="$OPTARG"
      ;;
    s)
      OPENSSL_PASS="$OPTARG"
      ;;
    h)
      echo "Uso: $0 [-d domínio] [-i ip do docker] [-s senha do certifdicado]"
      exit 0
      ;;
    :)
      echo "Opção -$OPTARG requer um argumento." >&2
      exit 1
      ;;
  esac
done

mkdir -p ../../../data/certbot/conf/live/${OPENSSL_CN}

echo -e "${LIGHT_RED}Deletando arquivos em data/certbot/conf/live...${NC}"
sudo rm -rf ../../../data/certbot/conf/live/${OPENSSL_CN}/privkey.key
sudo rm -rf ../../../data/certbot/conf/live/${OPENSSL_CN}/fullchain.crt

echo -e "${BROWN_ORANGE}Criando certificado para ${OPENSSL_CN}...${NC}"
echo -e "${BROWN_ORANGE}Dados usados:${NC}"
echo -e "${BROWN_ORANGE}CN = ${OPENSSL_CN}${NC}"
echo -e "${BROWN_ORANGE}CN = ${IP_ADDRESS}${NC}"
echo -e "${BROWN_ORANGE}CN = ${OPENSSL_PASS}${NC}"

openssl req -new -x509 -days 365 -out fullchain.crt -keyout privkey.key -inform PEM \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=${OPENSSL_CN}' -extensions EXT -config <( \
   printf "[dn]\nCN=${OPENSSL_CN}\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:${OPENSSL_CN}\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

chmod 400 *.crt
chmod 400 *.key

cp privkey.key ../../../data/certbot/conf/live/${OPENSSL_CN}/privkey.key
cp fullchain.crt ../../../data/certbot/conf/live/${OPENSSL_CN}/fullchain.crt

rm -rf *.pem
rm -rf *.jks
rm -rf *.der
rm -rf *.crt
rm -rf *.key
rm -rf *.pfx
rm -rf *.csr
rm -rf *.srl
rm -rf *.crt
rm -rf *.key