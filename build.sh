#!/bin/bash

docker build -t 772853327345.dkr.ecr.us-east-1.amazonaws.com/gomtl/golangmontreal.org:latest .
docker push 772853327345.dkr.ecr.us-east-1.amazonaws.com/gomtl/golangmontreal.org:latest
