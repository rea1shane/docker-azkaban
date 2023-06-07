# Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-the-solo-server

FROM openjdk:8 as builder

WORKDIR /src

RUN apt-get update && \
    # Fix: package javafx.util does not exist
    # See: https://github.com/docker-library/openjdk/issues/158#issuecomment-356412462
    apt-get install -y --no-install-recommends openjfx && \
    rm -rf /var/lib/apt/lists/*

ARG AZKABAN_VERSION

RUN git clone -b ${AZKABAN_VERSION} https://github.com/azkaban/azkaban.git && \
    # Fix: Could not GET 'https://nodejs.org/dist/v8.10.0/ivy.xml'. Received status code 403 from server: Forbidden
    # See: https://github.com/srs/gradle-node-plugin/issues/292#issuecomment-562848790
    sed -i 's/"com.moowork.node" version "1.2.0"/("com.github.node-gradle.node") version "2.2.0"/g' azkaban/azkaban-web-server/build.gradle && \
    cd azkaban; ./gradlew build installDist -x test

FROM amazoncorretto:8-alpine-jre

WORKDIR /app/azkaban

COPY --from=builder /src/azkaban/azkaban-solo-server/build/install/azkaban-solo-server .

RUN touch /tmp/block && \
    # Preventing automatic container exit.
    echo -e "\ntail -f /tmp/block" >> bin/start-solo.sh && \
    # In alpine, if you do not tell the parent shell which interpreter should be used in the script, you must manually specify it.
    sed -i 's/${script_dir}/sh ${script_dir}/g' bin/start-solo.sh

ENTRYPOINT [ "sh", "bin/start-solo.sh" ]

EXPOSE 8081
