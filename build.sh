#!/bin/zsh
#docker build  -t abraverm/foreman:devel .
docker build --build-arg FOREMAN="1.7-stable" --build-arg RUBY_VER="2.0.0" --build-arg WITHOUT="mysql2 pg test" -t abraverm/foreman:1.7 .
