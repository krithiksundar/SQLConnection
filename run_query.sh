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

echo "Attempting SQLPlus connection (timeout: 60 seconds)..."

# ---- FIX: wrap heredoc inside bash -c ----
timeout 60 sqlplus "$DB_USER/$DB_PASS@$DB_TNS"



