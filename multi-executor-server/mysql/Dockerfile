# Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#database-setup

FROM openjdk:8 as builder

ARG AZKABAN_VERSION

WORKDIR /src

RUN git clone -b ${AZKABAN_VERSION} https://github.com/azkaban/azkaban.git && \
    cd azkaban/azkaban-db; ../gradlew build installDist -x test

FROM mysql:5

ARG AZKABAN_VERSION

WORKDIR /docker-entrypoint-initdb.d

COPY user.sql .
COPY init.sql .
COPY --from=builder /src/azkaban/azkaban-db/build/distributions/azkaban-db-${AZKABAN_VERSION}.tar.gz .

RUN tar zxvf azkaban-db-${AZKABAN_VERSION}.tar.gz && \
    cat azkaban-db-${AZKABAN_VERSION}/create-all-sql-${AZKABAN_VERSION}.sql >> init.sql && \
    rm -rf azkaban-db-* && \
    sed -i '/\[mysqld\]/a max_allowed_packet=1024M' /etc/my.cnf

# https://stackoverflow.com/questions/42567475/docker-compose-check-if-mysql-connection-is-ready
HEALTHCHECK CMD [ "mysqladmin", "ping", "-h", "localhost" ]
