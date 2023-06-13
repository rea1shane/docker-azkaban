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

COPY ./activate-executor.sh .
COPY --from=builder /src/azkaban/azkaban-exec-server/build/install/azkaban-exec-server .

# Doc: https://www.cyberciti.biz/faq/how-to-install-curl-on-alpine-linux/
RUN apk --no-cache add curl && \
    # Fix: exec executable binary: not found
    # Doc: https://stackoverflow.com/a/66974607/21609053
    apk --no-cache add libc6-compat

RUN touch /tmp/block && \
    # Activate executor.
    echo -e "\nactivate-executor.sh\n" >> bin/start-exec.sh && \
    # Preventing automatic container exit.
    echo -e "\ntail -f /tmp/block" >> bin/start-exec.sh && \
    # Update mysql info.
    sed -i "s/mysql.host=localhost/mysql.host=${MYSQL_HOST}/g" conf/azkaban.properties && \
    sed -i "s/mysql.user=azkaban/mysql.user=${AZKABAN_MYSQL_USERNAME}/g" conf/azkaban.properties && \
    sed -i "s/mysql.password=azkaban/mysql.password=${AZKABAN_MYSQL_PASSWORD}/g" conf/azkaban.properties && \
    # Specify executor port.
    echo -e "\nexecutor.port=12321\n" >> conf/azkaban.properties

ENTRYPOINT [ "bin/start-exec.sh" ]

EXPOSE 12321
