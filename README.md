# Docker Azkaban

After version 3.0, Azkaban provide two modes: the [stand alone “solo-server” mode](#solo-server) and [distributed multiple-executor mode](#multi-executor-server).

## Solo Server

### Quick Start

To start a Azkaban solo server, run:

```shell
docker run --name azkaban-solo-server -p 8081:8081 -d rea1shane/azkaban-solo-server
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

View the available Azkaban versions in the [image repository](https://hub.docker.com/r/rea1shane/azkaban-solo-server).

## Multi Executor Server

coming soon...
