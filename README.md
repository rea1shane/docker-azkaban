# Docker Azkaban

[![solo-server-ci](https://github.com/rea1shane/docker-azkaban/actions/workflows/solo-server-ci.yml/badge.svg)](https://github.com/rea1shane/docker-azkaban/actions/workflows/solo-server-ci.yml)

After version 3.0, Azkaban provide two modes: the [stand alone “solo-server” mode](#solo-server) and [distributed multiple-executor mode](#multi-executor-server).

## Solo Server

The solo server is a standalone instance of Azkaban and the simplest to get started with.

### Quick Start

To start a Azkaban solo server, run:

```shell
docker run --name azkaban-solo-server -p 8081:8081 --platform linux/amd64 -d rea1shane/azkaban-solo-server
```

Then, you can access the Web UI at http://localhost:8081/. The default login username and password for the solo server are both azkaban which is configured in `/app/azkaban/conf/azkaban-users.xml` in the container.

### Customization

You can mount a custom configuration when you start the container. Azkaban is located at `/app/azkaban`:

```
/app/azkaban
├── bin
├── conf
│   ├── azkaban-users.xml
│   ├── azkaban.properties
│   └── global.properties
├── lib
├── plugins
├── sql
└── web
```

### Supported Azkaban Versions

View available Azkaban versions in the [image tags](https://hub.docker.com/r/rea1shane/azkaban-solo-server/tags).

## Multi Executor Server

coming soon...
