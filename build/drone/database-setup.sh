#!/bin/bash
# Script for preparing the databases for unit tests in Joomla!

# Path to the Joomla! installation

BASE=$(pwd)

# Setup databases for testing

echo "#### Setup MySQL Databases ####"
mysql -u root -h mysql -pjoomla_ut -e "create database joomla_70;create database joomla_71;create database joomla_72"

mysql -u root -h mysql -pjoomla_ut -e "GRANT ALL PRIVILEGES ON *.* TO 'joomla_ut'@'%';FLUSH PRIVILEGES;"

mysql -u root -h mysql -pjoomla_ut -e "ALTER DATABASE joomla_70 CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql -u root -h mysql -pjoomla_ut -e "ALTER DATABASE joomla_71 CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql -u root -h mysql -pjoomla_ut -e "ALTER DATABASE joomla_72 CHARACTER SET utf8 COLLATE utf8_general_ci;"


mysql -u root -h mysql -pjoomla_ut joomla_70 < "$BASE/tests/unit/schema/mysql.sql"
mysql -u root -h mysql -pjoomla_ut joomla_71 < "$BASE/tests/unit/schema/mysql.sql"
mysql -u root -h mysql -pjoomla_ut joomla_72 < "$BASE/tests/unit/schema/mysql.sql"
########

echo "#### Setup Postgres Databases ####"

psql -c 'create database joomla_70;'  -U postgres -h "postgres" > /dev/null
psql -c 'create database joomla_71;'  -U postgres -h "postgres" > /dev/null
psql -c 'create database joomla_72;'  -U postgres -h "postgres" > /dev/null

psql -U "postgres" -h "postgres" -d joomla_70 -a -f "$BASE/tests/unit/schema/postgresql.sql" > /dev/null
psql -U "postgres" -h "postgres" -d joomla_71 -a -f "$BASE/tests/unit/schema/postgresql.sql" > /dev/null
psql -U "postgres" -h "postgres" -d joomla_72 -a -f "$BASE/tests/unit/schema/postgresql.sql" > /dev/null

