# Docker Azkaban

Azkaban docker image.

## Usage

After version 3.0, Azkaban provide two modes: the [stand alone “solo-server” mode](#solo-server) and [distributed multiple-executor mode](#multi-executor-server).

### Solo server

[![solo-server-ci](https://github.com/rea1shane/docker-azkaban/actions/workflows/solo-server-ci.yml/badge.svg)](https://github.com/rea1shane/docker-azkaban/actions/workflows/solo-server-ci.yml)

To start a Azkaban solo server, run:

```shell
docker run --name azkaban-solo-server -p 8081:8081 --platform linux/amd64 -d rea1shane/azkaban-solo-server:3.90.0
```

Once the container is in the `healthy` state, you can access the Web UI at http://localhost:8081/. The default login username and password for the solo server are both azkaban which is configured in `/app/azkaban/conf/azkaban-users.xml` in the container.

You can mount custom configuration files when you start the container. Azkaban is located at `/app/azkaban`.

### Multi executor server

[![mysql-ci](https://github.com/rea1shane/docker-azkaban/actions/workflows/mysql-ci.yml/badge.svg)](https://github.com/rea1shane/docker-azkaban/actions/workflows/mysql-ci.yml)
[![executor-server-ci](https://github.com/rea1shane/docker-azkaban/actions/workflows/executor-server-ci.yml/badge.svg)](https://github.com/rea1shane/docker-azkaban/actions/workflows/executor-server-ci.yml)
[![web-server-ci](https://github.com/rea1shane/docker-azkaban/actions/workflows/web-server-ci.yml/badge.svg)](https://github.com/rea1shane/docker-azkaban/actions/workflows/web-server-ci.yml)

To start a Azkaban multi executor server, run:

```shell
cd multi-executor-server

docker-compose -p azkaban up -d --scale executor-server=3
```

Once all container are in the `healthy` state, you can access the Web UI at http://localhost:8081/. The default login username and password for the multi executor server are both azkaban which is configured in `/app/azkaban/conf/azkaban-users.xml` in the `azkaban-web-server` container.

You can mount custom configuration files when you start the compose. Executor server is located at `/app/azkaban-exec-server` and web server is located at `/app/azkaban-web-server`.

## Supported Azkaban versions

View available Azkaban versions in the [supported-azkaban-versions.json](https://github.com/rea1shane/docker-azkaban/blob/main/supported-azkaban-versions.json).
