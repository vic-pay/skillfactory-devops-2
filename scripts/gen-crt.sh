#!/bin/sh

SERVER_HOSTNAME=target-server
CA_KEY=ca-key.pem
CA_PEM=ca.pem
SERVER_KEY=server-key.pem
SERVER_CSR=server.csr
SERVER_PEM=server-cert.pem
CLIENT_KEY=client-key.pem
CLIENT_CSR=client.csr
CLIENT_PEM=client-cert.pem

echo "CA key gen"
openssl genrsa -aes256 -out $CA_KEY 4096

echo "CA pem gen"
openssl req -new -x509 -days 365 -key $CA_KEY -sha256 -out $CA_PEM -subj "/C=RU/ST=SPB/L=SPB/O=Skillfactory/OU=strudents/CN=$SERVER_HOSTNAME"

echo "Server key gen"
openssl genrsa -out $SERVER_KEY 4096

echo "Server csr gen"
openssl req -subj "/CN=$SERVER_HOSTNAME" -sha256 -new -key server-key.pem -out $SERVER_CSR
echo subjectAltName = DNS:$SERVER_HOSTNAME,IP:10.0.3.20,IP:127.0.0.1 >> server-extfile.cnf
echo extendedKeyUsage = serverAuth >> server-extfile.cnf

echo "Server cert gen"
openssl x509 -req -days 365 -sha256 -in $SERVER_CSR -CA $CA_PEM -CAkey $CA_KEY -CAcreateserial -out $SERVER_PEM -extfile server-extfile.cnf

echo "Client key gen"
openssl genrsa -out $CLIENT_KEY 4096

echo "Client csr gen"
openssl req -subj '/CN=client' -new -key $CLIENT_KEY -out $CLIENT_CSR
echo extendedKeyUsage = clientAuth > client-extfile.cnf

echo "Client cert gen"
openssl x509 -req -days 365 -sha256 -in $CLIENT_CSR -CA $CA_PEM -CAkey $CA_KEY \
  -CAcreateserial -out $CLIENT_PEM -extfile client-extfile.cnf

echo "Cleaning"
rm -v $CLIENT_CSR $SERVER_CSR client-extfile.cnf server-extfile.cnf

echo "Coping files to server role"
cp $CA_PEM     ../roles/docker-server/files/etc/docker
cp $SERVER_KEY ../roles/docker-server/files/etc/docker
cp $SERVER_PEM ../roles/docker-server/files/etc/docker

echo "Coping files to client role"
cp $CA_PEM     ../roles/docker-client/files/etc/docker
cp $CLIENT_KEY ../roles/docker-client/files/etc/docker
cp $CLIENT_PEM ../roles/docker-client/files/etc/docker



