# Docker-HTPPLab

[![Build Status](https://travis-ci.org/Cyconet/docker-httplab.svg?branch=development)](https://travis-ci.org/Cyconet/docker-httplab)
[![Docker Build Status](https://img.shields.io/docker/build/waja/httplab.svg)](https://hub.docker.com/r/waja/httplab/)
[![GitHub tag](https://img.shields.io/github/tag/Cyconet/docker-httplab.svg)](https://github.com/Cyconet/docker-httplab/tags)
[![](https://img.shields.io/docker/pulls/waja/httplab.svg)](https://hub.docker.com/r/waja/httplab/)
[![](https://img.shields.io/docker/stars/waja/httplab.svg)](https://hub.docker.com/r/waja/httplab/)
[![](https://img.shields.io/docker/automated/waja/httplab.svg)](https://hub.docker.com/r/waja/httplab/)

Builds a docker image with the [httplab](https://github.com/gchaincl/httplab) ready to run.

Running
-------

- run the docker container with:

```
docker run --rm -it waja/httplab --help 
```

Building
--------

```
make build
```

Get a shell in a running container
----------------------------------

```
make shell
```
