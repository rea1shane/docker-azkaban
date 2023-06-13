#!/bin/sh

# Log file not exist or server not started
while [ $(ls | grep executorServerLog > /dev/null; echo $?) -ne 0 ] || [ $(grep "Started SocketConnector" $(ls -lt . | grep executorServerLog | head -n 1 | awk '{print $9}') > /dev/null; echo $?) -ne 0 ]
do
    sleep 1
done

# https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-executor-server
curl -G "http://localhost:$(cat ./executor.port)/executor?action=activate" && echo
