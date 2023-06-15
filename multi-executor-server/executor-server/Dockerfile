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
COPY activate-executor.sh bin

# Doc: https://www.cyberciti.biz/faq/how-to-install-curl-on-alpine-linux/
RUN apk --no-cache add curl

RUN sed -i '2i \\necho Starting...' bin/start-exec.sh && \
    # Activate executor.
    echo 'echo Activating...' >> bin/start-exec.sh && \
    echo '${script_dir}/activate-executor.sh' >> bin/start-exec.sh && \
    echo -e 'echo Executor has been started and activated.\n' >> bin/start-exec.sh && \
    # trap `docker stop` signal
    echo -e 'trap "echo Stopping...; ${script_dir}/shutdown-exec.sh > /dev/null; echo Executor is stopped and has been removed from the executors list.; exit" SIGTERM\n' >> bin/start-exec.sh && \
    # Blocking program.
    echo -e 'while true; do sleep 0.1; done' >> bin/start-exec.sh && \
    # In alpine, you must add `sh` before execable binary.
    # See: https://stackoverflow.com/questions/66963068/docker-alpine-executable-binary-not-found-even-if-in-path/66974607#66974607
    sed -i 's/${script_dir}/sh ${script_dir}/g' bin/start-exec.sh && \
    # Update MySQL info
    sed -i "s/mysql.host=localhost/mysql.host=${MYSQL_HOST}/g" conf/azkaban.properties && \
    sed -i "s/mysql.user=azkaban/mysql.user=${AZKABAN_MYSQL_USERNAME}/g" conf/azkaban.properties && \
    sed -i "s/mysql.password=azkaban/mysql.password=${AZKABAN_MYSQL_PASSWORD}/g" conf/azkaban.properties && \
    # Specify executor port
    echo -e 'executor.port=12321\n' >> conf/azkaban.properties

ENTRYPOINT [ "sh", "bin/start-exec.sh" ]

EXPOSE 12321

HEALTHCHECK --interval=10s --timeout=10s --start-period=10s --retries=3 \
    CMD [ "sh", "bin/activate-executor.sh" ]
