# Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#database-setup

FROM openjdk:8 as builder

ARG AZKABAN_VERSION

WORKDIR /src

RUN git clone -b ${AZKABAN_VERSION} https://github.com/azkaban/azkaban.git && \
    cd azkaban/azkaban-db; ../gradlew build installDist -x test

FROM mysql:latest

ARG AZKABAN_VERSION
ARG AZKABAN_MYSQL_USERNAME
ARG AZKABAN_MYSQL_PASSWORD

WORKDIR /docker-entrypoint-initdb.d

COPY init.sql .
COPY --from=builder /src/azkaban/azkaban-db/build/distributions/azkaban-db-${AZKABAN_VERSION}.tar.gz .

RUN echo -e "\nCREATE USER '${AZKABAN_MYSQL_USERNAME}'@'%' IDENTIFIED BY '${AZKABAN_MYSQL_PASSWORD}';\n" >> init.sql && \
    echo -e "\nGRANT SELECT,INSERT,UPDATE,DELETE ON azkaban.* to '${AZKABAN_MYSQL_USERNAME}'@'%' WITH GRANT OPTION;\n" >> init.sql && \
    tar zxvf azkaban-db-${AZKABAN_VERSION}.tar.gz && \
    cat azkaban-db-${AZKABAN_VERSION}/create-all-sql-${AZKABAN_VERSION}.sql >> init.sql && \
    rm -rf azkaban*
