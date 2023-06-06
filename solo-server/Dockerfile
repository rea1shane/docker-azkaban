# doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-the-solo-server

FROM openjdk:8 as builder

WORKDIR /src

RUN apt-get update && \
    # fix: package javafx.util does not exist
    # more info: https://github.com/docker-library/openjdk/issues/158#issuecomment-356412462
    apt-get install -y --no-install-recommends openjfx && \ 
    rm -rf /var/lib/apt/lists/*

RUN git clone -b 3.90.0 https://github.com/azkaban/azkaban.git && \
    # fix: Could not GET 'https://nodejs.org/dist/v8.10.0/ivy.xml'. Received status code 403 from server: Forbidden
    # more info: https://github.com/srs/gradle-node-plugin/issues/292#issuecomment-562848790
    sed  -i 's/"com.moowork.node" version "1.2.0"/("com.github.node-gradle.node") version "2.2.0"/g' azkaban/azkaban-web-server/build.gradle && \
    cd azkaban; ./gradlew build installDist -x test

FROM openjdk:8

WORKDIR /app/azkaban

COPY --from=builder /src/azkaban/azkaban-solo-server/build/install/azkaban-solo-server .

ENTRYPOINT [ "bin/start-solo.sh" ]

EXPOSE 8081
