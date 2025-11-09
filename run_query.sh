#!/bin/bash
set -e

source tnsdetails.env

echo "Connecting to Oracle and executing query..."
echo "" > output.txt

sqlplus -s "$DB_USER/$DB_PASS@$DB_TNS" <<EOF >> output.txt
SET HEADING OFF
SET FEEDBACK OFF
SET PAGESIZE 0
@query.sql
EXIT
EOF

echo "✅ Query executed successfully. Results saved to output.txt"
