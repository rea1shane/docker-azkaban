# Docker Azkaban

[Azkaban](https://azkaban.github.io/) Docker image.

After version 3.0, Azkaban provide two modes: the [stand alone “solo-server” mode](#solo-server) and [distributed multiple-executor mode](#multi-executor-server).

## Solo server

### Usage

[![solo-server-ci](https://github.com/rea1shane/docker-azkaban/actions/workflows/solo-server-ci.yml/badge.svg)](https://github.com/rea1shane/docker-azkaban/actions/workflows/solo-server-ci.yml)

Run:

```shell
docker run --name azkaban-solo-server -p 8081:8081 --platform linux/amd64 -d rea1shane/azkaban-solo-server:3.90.0
```

Once the container is in the healthy state, you can access the Web UI at http://localhost:8081/. The default login username and password for the solo server are both azkaban which is configured in `/app/azkaban/conf/azkaban-users.xml` in the container.

You can mount custom configuration files when you start the container. Azkaban is located at `/app/azkaban`.

### Build

Run:

```shell
docker build -t azkaban-solo-server --build-arg AZKABAN_VERSION=3.90.0 solo-server
```

## Multi executor server

### Usage

[![mysql-ci](https://github.com/rea1shane/docker-azkaban/actions/workflows/mysql-ci.yml/badge.svg)](https://github.com/rea1shane/docker-azkaban/actions/workflows/mysql-ci.yml)
[![executor-server-ci](https://github.com/rea1shane/docker-azkaban/actions/workflows/executor-server-ci.yml/badge.svg)](https://github.com/rea1shane/docker-azkaban/actions/workflows/executor-server-ci.yml)
[![web-server-ci](https://github.com/rea1shane/docker-azkaban/actions/workflows/web-server-ci.yml/badge.svg)](https://github.com/rea1shane/docker-azkaban/actions/workflows/web-server-ci.yml)

Run:

```shell
docker-compose -f multi-executor-server/docker-compose.yaml -p azkaban up -d --scale executor-server=3
```

Once all container are in the healthy state, you can access the Web UI at http://localhost:8081/. The default login username and password for the multi executor server are both azkaban which is configured in `/app/azkaban-web-server/conf/azkaban-users.xml` in the azkaban-web-server container.

You can mount custom configuration files when you start the compose. Executor server is located at `/app/azkaban-exec-server` and web server is located at `/app/azkaban-web-server`.

### Build

Run:

```shell
docker-compose -f multi-executor-server/docker-compose.yaml build
```

## Supported Azkaban versions

View available Azkaban versions in the [supported-azkaban-versions.json](https://github.com/rea1shane/docker-azkaban/blob/main/supported-azkaban-versions.json).

These docker files may also support more versions, but due to time constraints I did not test them extensively and add them to the list. If any version has been supported or is needed, please create an issue or PR to let me know!
