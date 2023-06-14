# Docker Azkaban

Azkaban docker image.

## Usage

After version 3.0, Azkaban provide two modes: the [stand alone “solo-server” mode](#solo-server) and [distributed multiple-executor mode](#multi-executor-server).

### Solo server

[![solo-server-ci](https://github.com/rea1shane/docker-azkaban/actions/workflows/solo-server-ci.yml/badge.svg)](https://github.com/rea1shane/docker-azkaban/actions/workflows/solo-server-ci.yml)

To start a Azkaban solo server, run:

```shell
docker run --name azkaban-solo-server -p 8081:8081 --platform linux/amd64 -d rea1shane/azkaban-solo-server
```

Then, you can access the Web UI at http://localhost:8081/. The default login username and password for the solo server are both azkaban which is configured in `/app/azkaban/conf/azkaban-users.xml` in the container.

You can mount custom configuration files when you start the container. Azkaban is located at `/app/azkaban`:

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

### Multi executor server

[![executor-server-ci](https://github.com/rea1shane/docker-azkaban/actions/workflows/executor-server-ci.yml/badge.svg)](https://github.com/rea1shane/docker-azkaban/actions/workflows/executor-server-ci.yml)

Coming soon...

## Supported Azkaban versions

View available Azkaban versions in the [supported-azkaban-versions.json](https://github.com/rea1shane/docker-azkaban/blob/main/supported-azkaban-versions.json).
