#!/bin/bash
set -euo pipefail
set -x

# First, load environment variables
source tnsdetails.env

# Now you can safely reference them
echo "DB_USER=$DB_USER"
echo "DB_TNS=$DB_TNS"
echo "DB_PASS=${DB_PASS:0:4}****"

# Check sqlplus
which sqlplus || { echo "sqlplus not found in PATH"; exit 1; }

echo "Connecting to Oracle and executing query..."
> output.txt

sqlplus -s "$DB_USER/$DB_PASS@$DB_TNS" <<EOF >> output.txt 2>&1
SET HEADING OFF
SET FEEDBACK OFF
SET PAGESIZE 0
@query.sql
EXIT
EOF

cat output.txt
echo "Query executed successfully. Results saved to output.txt"
