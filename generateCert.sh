#!/bin/bash
CWD=$(dirname $(realpath "$0"))
cd ${CWD}
echo "----------Generating rootCA.key----------"
echo "executing: openssl genrsa -des3 -out rootCA.key 2048"
openssl genrsa -des3 -out rootCA.key 2048
echo "----------Generating rootCA.pem----------"
echo "executing: openssl req -x509 -new -nodes -key \n rootCA.key -sha256 -days 1024 -out rootCA.pem"
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem
echo "----------Taking Your Certification info----------"
echo "----------from server.csr.cnf & v3.ext-----------"
echo "----------Generating server.crt-----------"
echo "executing:openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial"
echo "         -out server.crt -days 500 -sha256 -extfile v3.ext"

openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config <( cat server.csr.cnf )

echo "----Upload server.crt & server.key in /etc/apache2/sites-enabled/{ssl-config}.conf and upload rootCA.pem in the browser" 
