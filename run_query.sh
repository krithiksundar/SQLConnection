#!/bin/bash
set -euo pipefail
set -x

# First, load environment variables
source tnsdetails.env

echo "DB_USER=$DB_USER"
echo "DB_TNS=$DB_TNS"
echo "DB_PASS=${DB_PASS:0:4}****"

echo "192.168.0.107 sdb sdb.localdomain" >> /etc/hosts
echo "Connecting to Oracle and executing query..."
> output.txt

echo > /dev/tcp/192.168.0.107/1521 && echo "Port open" || echo "Port closed"

echo "Testing Oracle DB connection..."
echo "--------------------------------"

timeout 120 sqlplus -S "$DB_USER/$DB_PASS@$DB_TNS" <<EOF
SET HEADING OFF
SET FEEDBACK OFF
SELECT 'Connection Successful!' FROM dual;
EXIT;
EOF

echo "--------------------------------"
echo "Done"



