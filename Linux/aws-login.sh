#!/bin/bash

aws sso login

aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 306315756373.dkr.ecr.us-east-2.amazonaws.com
