FROM openjdk:8

WORKDIR /src

RUN apt-get update && \
    # javafx
    apt-get install -y --no-install-recommends openjfx && \ 
    rm -rf /var/lib/apt/lists/*

RUN git clone -b 3.90.0 https://github.com/azkaban/azkaban.git && \
    # https://github.com/srs/gradle-node-plugin/issues/292#issuecomment-562848790
    sed  -i 's/"com.moowork.node" version "1.2.0"/("com.github.node-gradle.node") version "2.2.0"/g' azkaban/azkaban-web-server/build.gradle && \
    cd azkaban; ./gradlew build installDist -x test

ENTRYPOINT [ "cd azkaban/azkaban-solo-server/build/install/azkaban-solo-server; bin/start-solo.sh" ]

EXPOSE 8081
