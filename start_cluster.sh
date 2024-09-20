#!/bin/bash
cp -r origin/.tucd .tucd
cp -r origin/.tucd2 .tucd2
cp -r origin/.tucd3 .tucd3
cp -r origin/.tucd4 .tucd4

docker-compose -f docker-compose.yml up -d