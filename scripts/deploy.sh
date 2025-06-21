#!/bin/bash

set -e

make build

systemctl stop go-deploy-demo || true

cp bin/go-deploy-demo /usr/local/bin/go-deploy-demo

systemctl start go-deploy-demo

echo "Deploy done."