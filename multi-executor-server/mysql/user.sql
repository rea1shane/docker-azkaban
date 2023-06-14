-- Doc: https://azkaban.readthedocs.io/en/latest/getStarted.html#database-setup

CREATE USER 'azkaban'@'%' IDENTIFIED BY 'azkaban';

GRANT SELECT,INSERT,UPDATE,DELETE ON azkaban.* to 'azkaban'@'%' WITH GRANT OPTION;
