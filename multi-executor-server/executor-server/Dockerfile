# Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-executor-server

FROM openjdk:8 as builder

ARG AZKABAN_VERSION

WORKDIR /src

RUN git clone -b ${AZKABAN_VERSION} https://github.com/azkaban/azkaban.git && \
    cd azkaban/azkaban-exec-server; ../gradlew build installDist -x test

FROM amazoncorretto:8-alpine-jre

ENV MYSQL_HOST=host.docker.internal
ENV AZKABAN_MYSQL_USERNAME=azkaban
ENV AZKABAN_MYSQL_PASSWORD=azkaban

WORKDIR /app/azkaban-exec-server

# Doc: https://www.cyberciti.biz/faq/how-to-install-curl-on-alpine-linux/
RUN apk --no-cache add curl

COPY --from=builder /src/azkaban/azkaban-exec-server/build/install/azkaban-exec-server .
COPY init-exec.sh bin
COPY activate-exec.sh bin

RUN sed -i '5i echo Initializing...\n${script_dir}/init-exec.sh > /dev/null\necho Done.\n' bin/start-exec.sh && \
    sed -i '9i echo Starting...\n' bin/start-exec.sh && \
    # Activate
    echo 'echo Activating...' >> bin/start-exec.sh && \
    echo '${script_dir}/activate-exec.sh' >> bin/start-exec.sh && \
    echo -e 'echo Executor has been started and activated.\n' >> bin/start-exec.sh && \
    # trap `docker stop` signal
    echo -e 'trap "echo Stopping...; ${script_dir}/shutdown-exec.sh > /dev/null; echo Executor is stopped and has been removed from the executors list.; exit" SIGTERM\n' >> bin/start-exec.sh && \
    # Blocking program.
    echo -e 'while true; do sleep 0.1; done' >> bin/start-exec.sh && \
    # In alpine, you must add `sh` before execable binary.
    # See: https://stackoverflow.com/questions/66963068/docker-alpine-executable-binary-not-found-even-if-in-path/66974607#66974607
    sed -i 's/${script_dir}/sh ${script_dir}/g' bin/start-exec.sh && \
    # Specify executor port
    echo "executor.port=12321" >> conf/azkaban.properties

ENTRYPOINT [ "sh", "bin/start-exec.sh" ]

EXPOSE 12321

HEALTHCHECK CMD [ "curl", "-G", "localhost:12321/executor?action=activate" ]
