#!/bin/bash

command_exists() {
    type "$1" &>/dev/null
}

if ! command_exists aws; then
    echo "ERROR: You need to install aws cli before run this"
    exit 1
fi

aws sso login
echo ""

if command_exists docker; then
    aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 306315756373.dkr.ecr.us-east-2.amazonaws.com
fi

if [ $? -ne 0 ]; then
    if [ $1 -eq "pip" ]; then
        aws codeartifact login --tool pip --repository pypip-packages --domain passeidireto --domain-owner 306315756373
    elif [ $1 -eq "npm" ]; then
        aws codeartifact login --tool npm --repository npm-packages --domain passeidireto --namespace @passeidireto
    fi
fi

echo ""
read -rsn1 -p "Press any key to exit"
echo ""
