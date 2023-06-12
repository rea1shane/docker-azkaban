# Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-executor-server

FROM openjdk:8

ARG AZKABAN_VERSION

WORKDIR /src

RUN git clone -b ${AZKABAN_VERSION} https://github.com/azkaban/azkaban.git && \
    cd azkaban/azkaban-exec-server; ../gradlew build installDist -x test
