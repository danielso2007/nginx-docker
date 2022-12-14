#!/bin/bash
openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout RootCA.key -out RootCA.pem -subj "/C=BR/ST=RiodeJaneiro/L=RiodeJaneiro/O=Example-CA/CN=Example-Root-CA"
openssl x509 -outform pem -in RootCA.pem -out RootCA.crt
openssl req -new -nodes -newkey rsa:2048 -keyout privkey.pem -out fullchain.pem -subj "/C=BR/ST=RiodeJaneiro/L=RiodeJaneiro/O=Example-Certificates/CN=tomcat.example.com"
openssl x509 -req -sha256 -days 1024 -in fullchain.pem -CA RootCA.pem -CAkey RootCA.key -CAcreateserial -extfile tomcat.ext -out fullchain.pem

sudo apt-get install libnss3-tools
openssl pkcs12 -export -out tomcat.example.com.pfx -inkey privkey.pem -in fullchain.pem
pk12util -d sql:$HOME/.pki/nssdb -i tomcat.example.com.pfx
certutil -d sql:$HOME/.pki/nssdb -A -t "P,," -n 'dev cert' -i fullchain.pem

mv -f fullchain.pem ../data/certbot/conf/live/tomcat.example.com/fullchain.pem
mv -f privkey.pem ../data/certbot/conf/live/tomcat.example.com/privkey.pem