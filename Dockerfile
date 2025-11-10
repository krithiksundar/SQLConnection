FROM container-registry.oracle.com/database/instantclient:latest

WORKDIR /app
COPY . /app

# Ensure the script is executable
RUN chmod +x run_query.sh

# Force LF line endings for scripts and env files
RUN sed -i 's/\r$//' run_query.sh
RUN sed -i 's/\r$//' tnsdetails.env

# Debug: check script content and line endings
RUN echo "Listing files in /app:" && ls -l /app
RUN echo "Checking first 10 lines of run_query.sh (CRLF should show ^M):" && head -n 10 run_query.sh | cat -v
RUN echo "Checking first 10 lines of tnsdetails.env:" && head -n 10 tnsdetails.env | cat -v
RUN echo "Default shell: $SHELL"

# Automatically detect Oracle Instant Client path and add to PATH yes
RUN ORACLE_HOME=$(find / -type d -name "instantclient*" -print -quit) && \
    echo "Detected ORACLE_HOME: $ORACLE_HOME" && \
    echo $ORACLE_HOME >> /etc/environment && \
    export PATH=$PATH:$ORACLE_HOME

# Use bash to run your script
CMD ["bash", "run_query.sh"]
