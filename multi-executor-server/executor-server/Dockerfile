# Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-executor-server

FROM openjdk:8 as builder

ARG AZKABAN_VERSION

WORKDIR /src

RUN git clone -b ${AZKABAN_VERSION} https://github.com/azkaban/azkaban.git && \
    cd azkaban/azkaban-exec-server; ../gradlew build installDist -x test

FROM amazoncorretto:8-alpine-jre

ARG MYSQL_HOST=mysql
ARG AZKABAN_MYSQL_USERNAME=azkaban
ARG AZKABAN_MYSQL_PASSWORD=azkaban

WORKDIR /app/azkaban-exec-server

COPY --from=builder /src/azkaban/azkaban-exec-server/build/install/azkaban-exec-server .

RUN touch /tmp/block && \
    # Preventing automatic container exit.
    echo -e "\ntail -f /tmp/block" >> bin/start-exec.sh && \
    # In alpine, if you do not tell the parent shell which interpreter should be used in the script, you must manually specify it.
    sed -i 's/${script_dir}/sh ${script_dir}/g' bin/start-exec.sh && \
    sed -i "s/mysql.host=localhost/mysql.host=${MYSQL_HOST}/g" conf/azkaban.properties && \
    sed -i "s/mysql.user=azkaban/mysql.user=${AZKABAN_MYSQL_USERNAME}/g" conf/azkaban.properties && \
    sed -i "s/mysql.password=azkaban/mysql.password=${AZKABAN_MYSQL_PASSWORD}/g" conf/azkaban.properties

ENTRYPOINT [ "sh", "bin/start-exec.sh" ]
