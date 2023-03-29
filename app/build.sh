#!/bin/bash

docker build -t localhost:5000/app .

docker push localhost:5000/app
