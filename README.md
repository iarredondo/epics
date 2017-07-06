# EPICS docker container

This docker container implements a vanilla EPICS base 3.16.1

To use it
1.- Create a Dockerfile in your preferred folder
FROM iarredondo/epics

2.- Run:
$ docker build -t epics .
$ docker run --name epics --rm -p 5064:5064 -p 5064:5064/udp -p 5065:5065 -p 5065:5065/udp -it epics-server bash

This container can be used in combination with iarredondo/epics-server. This one creates a softioc as a service.
