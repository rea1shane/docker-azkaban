#!/bin/sh

script_dir=$(dirname $0)

# [ log file not exist ] or [ server not started ] or [ request failure ]
while [ $(ls ${script_dir}/.. | grep executorServerLog > /dev/null; echo $?) -ne 0 ] || \
    [ $(grep "Started SocketConnector" $(ls -lt ${script_dir}/.. | grep executorServerLog | head -n 1 | awk '{print $9}') > /dev/null; echo $?) -ne 0 ] || \
    # https://azkaban.readthedocs.io/en/latest/getStarted.html#installing-azkaban-executor-server
    [ $(curl --silent -G "localhost:$(cat ${script_dir}/../executor.port)/executor?action=activate" > /dev/null; echo $?) -ne 0 ]
do
    sleep 1
done

echo "Executor has been started and activated."
