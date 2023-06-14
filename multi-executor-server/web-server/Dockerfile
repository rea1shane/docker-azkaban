# Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-web-server

FROM openjdk:8 as builder

ARG AZKABAN_VERSION

WORKDIR /src

RUN git clone -b ${AZKABAN_VERSION} https://github.com/azkaban/azkaban.git && \
    # Fix: Could not GET 'https://nodejs.org/dist/v8.10.0/ivy.xml'. Received status code 403 from server: Forbidden
    # See: https://github.com/srs/gradle-node-plugin/issues/292#issuecomment-562848790
    sed -i 's/"com.moowork.node" version "1.2.0"/("com.github.node-gradle.node") version "2.2.0"/g' azkaban/azkaban-web-server/build.gradle && \
    cd azkaban/azkaban-web-server; ../gradlew build installDist -x test

FROM amazoncorretto:8-alpine-jre

ARG MYSQL_HOST=mysql
ARG AZKABAN_MYSQL_USERNAME=azkaban
ARG AZKABAN_MYSQL_PASSWORD=azkaban

WORKDIR /app/azkaban-web-server

COPY --from=builder /src/azkaban/azkaban-web-server/build/install/azkaban-web-server .

# trap `docker stop` signal
RUN echo -e 'trap "${script_dir}/shutdown-web.sh > /dev/null; exit" SIGTERM\n' >> bin/start-web.sh && \
    # Blocking program.
    echo -e 'while true; do sleep 0.1; done' >> bin/start-web.sh && \
    # In alpine, you must add `sh` before execable binary.
    # See: https://stackoverflow.com/questions/66963068/docker-alpine-executable-binary-not-found-even-if-in-path/66974607#66974607
    sed -i 's/${script_dir}/sh ${script_dir}/g' bin/start-web.sh && \
    # Update MySQL info
    sed -i "s/mysql.host=localhost/mysql.host=${MYSQL_HOST}/g" conf/azkaban.properties && \
    sed -i "s/mysql.user=azkaban/mysql.user=${AZKABAN_MYSQL_USERNAME}/g" conf/azkaban.properties && \
    sed -i "s/mysql.password=azkaban/mysql.password=${AZKABAN_MYSQL_PASSWORD}/g" conf/azkaban.properties

ENTRYPOINT [ "sh", "bin/start-web.sh" ]

EXPOSE 8081
