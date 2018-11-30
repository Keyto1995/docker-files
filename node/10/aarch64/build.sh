#!/bin/sh
docker build --rm --build-arg make_jobs=3 -t keyto/node-arm64:10 .