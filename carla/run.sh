#!/bin/bash

docker container run --rm -it -e SDL_VIDEODRIVER=x11 -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --add-host=localhost:172.17.0.1 -p 2000-2002:2000-2002 --gpus all carlasim/carla:0.9.10.1 ./CarlaUE4.sh -opengl