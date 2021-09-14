#!/bin/bash

docker run -d -p 2375:2375 --cpus="4" --memory=1512m --name ubuntu -v .:/workspace ubuntu:focal
