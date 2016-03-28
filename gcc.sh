#!/bin/bash
echo $1
docker run -v $PWD:/tmp -w /tmp gcc $1