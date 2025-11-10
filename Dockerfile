FROM container-registry.oracle.com/database/instantclient:latest

WORKDIR /app
COPY . /app

# Ensure the script is executable
RUN chmod +x run_query.sh



# Automatically detect Oracle Instant Client path and add to PATH
RUN ORACLE_HOME=$(find / -type d -name "instantclient*" -print -quit) && \
    echo "Detected ORACLE_HOME: $ORACLE_HOME" && \
    echo $ORACLE_HOME >> /etc/environment && \
    export PATH=$PATH:$ORACLE_HOME

# Use bash to run your script
CMD ["bash", "run_query.sh"]
