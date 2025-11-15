#!/bin/bash
set -euo pipefail
set -x

# First, load environment variables
source tnsdetails.env

echo "DB_USER=$DB_USER"
echo "DB_TNS=$DB_TNS"
echo "DB_PASS=${DB_PASS:0:4}****"

echo "Connecting to Oracle and executing query..."
> output.txt

echo "Attempting SQLPlus connection (timeout: 60 seconds)..."

# ---- FIX: wrap heredoc inside bash -c ----
timeout 60 bash -c "
sqlplus \"$DB_USER/$DB_PASS@$DB_TNS\" <<'EOF' >> output.txt 2>&1
SET HEADING OFF
SET FEEDBACK OFF
SET PAGESIZE 0
@query.sql
EXIT
EOF
"

status=$?

if [ $status -eq 124 ]; then
    echo 'ERROR: SQLPlus timed out after 60 seconds!'
    echo '----- SQL Output Start -----'
    cat output.txt
    echo '----- SQL Output End -----'
    exit 1

elif [ $status -ne 0 ]; then
    echo "ERROR: SQLPlus failed with exit code $status"
    echo '----- SQL Output Start -----'
    cat output.txt
    echo '----- SQL Output End -----'
    exit 1
fi
