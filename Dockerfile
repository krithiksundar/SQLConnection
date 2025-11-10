FROM container-registry.oracle.com/database/instantclient:latest

WORKDIR /app
COPY . /app

# Ensure the script is executable
RUN chmod +x run_query.sh

# Debug: check files inside container
RUN echo "Files in /app:" && ls -l /app
RUN echo "run_query.sh type:" && file run_query.sh
RUN head -n 30 run_query.sh

# Automatically detect Oracle Instant Client path and add to PATH yes
RUN ORACLE_HOME=$(find / -type d -name "instantclient*" -print -quit) && \
    echo "Detected ORACLE_HOME: $ORACLE_HOME" && \
    echo $ORACLE_HOME >> /etc/environment && \
    export PATH=$PATH:$ORACLE_HOME

# Use bash to run your script
CMD ["bash", "run_query.sh"]
