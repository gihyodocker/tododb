#!/bin/bash -e

if [ ! -z "$MYSQL_MASTER" ]; then
  echo "this container is master"
  return 0
fi

echo "prepare as slave"

# health check to master
while :
do
  if mysql -h master -u root -p$MYSQL_ROOT_PASSWORD -e "quit" > /dev/null 2>&1 ; then
    echo "MySQL master is ready!"
    break
  else
    echo "MySQL master is not ready"
  fi
  sleep 3
done

# check existance of tables in master database
if mysql -h master -u root -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE -e "show tables;" | wc -l ; then
  MASTER_DATA_EMPTY=true
else
  MASTER_DATA_EMPTY=false
fi

# create replication user
mysql -h master -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER 'repl'@'`hostname -i`' IDENTIFIED BY '$MYSQL_REPL_PASSWORD';"
mysql -h master -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT REPLICATION SLAVE ON *.* TO '$MYSQL_REPL_USER'@'`hostname -i`';"

# get master status
MASTER_STATUS_FILE=/tmp/master-status
mysql -h master -u root -p$MYSQL_ROOT_PASSWORD -e "SHOW MASTER STATUS\G" > $MASTER_STATUS_FILE
BINLOG_FILE=`cat $MASTER_STATUS_FILE | grep File | xargs | cut -d' ' -f2`
BINLOG_POSITION=`cat $MASTER_STATUS_FILE | grep Position | xargs | cut -d' ' -f2`
echo "BINLOG_FILE=$BINLOG_FILE"
echo "BINLOG_POSITION=$BINLOG_POSITION"

# start replication
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CHANGE MASTER TO MASTER_HOST='master', MASTER_USER='$MYSQL_REPL_USER', MASTER_PASSWORD='$MYSQL_REPL_PASSWORD', MASTER_LOG_FILE='$BINLOG_FILE', MASTER_LOG_POS=$BINLOG_POSITION;"
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "START SLAVE;"

echo "slave started"
