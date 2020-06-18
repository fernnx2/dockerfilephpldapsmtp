#!/bin/bash

docker rmi phpldapsmtp
docker stop serve1 serve2 serve3
docker rm serve1 serve2 serve3
