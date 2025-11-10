FROM container-registry.oracle.com/database/instantclient:latest

WORKDIR /app
COPY . /app

# Install dos2unix, convert the script, and make it executable
RUN apt-get update && \
    apt-get install -y dos2unix && \
    dos2unix run_query.sh && \
    chmod +x run_query.sh


# Automatically detect Oracle Instant Client path and add to PATH
RUN ORACLE_HOME=$(find / -type d -name "instantclient*" -print -quit) && \
    echo "Detected ORACLE_HOME: $ORACLE_HOME" && \
    echo $ORACLE_HOME >> /etc/environment && \
    export PATH=$PATH:$ORACLE_HOME

# Use bash to run your script
CMD ["bash", "run_query.sh"]
