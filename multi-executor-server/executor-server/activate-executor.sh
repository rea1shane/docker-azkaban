#!/bin/sh

# [ log file not exist ] or [ server not started ] or [ request failure ]
while [ $(ls | grep executorServerLog > /dev/null; echo $?) -ne 0 ] || \
    [ $(grep "Started SocketConnector" $(ls -lt . | grep executorServerLog | head -n 1 | awk '{print $9}') > /dev/null; echo $?) -ne 0 ] || \
    # https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-executor-server
    [ $(curl --silent -G "http://localhost:$(cat ./executor.port)/executor?action=activate" > /dev/null; echo $?) -ne 0 ]
do
    sleep 1
done

echo "Executor has been started and activated."
