#!/bin/sh

script_dir=$(dirname $0)

# Update MySQL setting
sed -i "s/mysql.host=localhost/mysql.host=$MYSQL_HOST/g" ${script_dir}/../conf/azkaban.properties
sed -i "s/mysql.user=azkaban/mysql.user=$AZKABAN_MYSQL_USERNAME/g" ${script_dir}/../conf/azkaban.properties
sed -i "s/mysql.password=azkaban/mysql.password=$AZKABAN_MYSQL_PASSWORD/g" ${script_dir}/../conf/azkaban.properties
