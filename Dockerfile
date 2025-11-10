FROM container-registry.oracle.com/database/instantclient:latest

WORKDIR /app
COPY . /app

RUN chmod +x run_query.sh
RUN sed -i 's/\r$//' run_query.sh
RUN sed -i 's/\r$//' tnsdetails.env

# Permanent ORACLE_HOME and PATH
ENV ORACLE_HOME=/usr/lib/oracle/12.2/client64
ENV PATH=$PATH:$ORACLE_HOME

# Optional debug to verify sqlplus
RUN which sqlplus || (echo "sqlplus not found in PATH" && exit 1)

CMD ["bash", "-c", "echo 'Running run_query.sh...' && bash run_query.sh && cat output.txt"]

