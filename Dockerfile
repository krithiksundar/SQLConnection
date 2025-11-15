FROM container-registry.oracle.com/database/instantclient:latest
# Add Oracle host to container /etc/hosts
RUN printf "$(cat /etc/hosts)\n192.168.0.107 sdb sdb.localdomain\n" > /etc/hosts.new \
    && mv /etc/hosts.new /etc/hosts


WORKDIR /app
COPY . /app

RUN chmod +x run_query.sh
RUN sed -i 's/\r$//' run_query.sh
RUN sed -i 's/\r$//' tnsdetails.env

# Permanent ORACLE_HOME and PATH
ENV ORACLE_HOME=/usr/lib/oracle/12.2/client64
ENV PATH=$PATH:$ORACLE_HOME

CMD ["bash", "-c", "echo 'Running run_query.sh...' && bash run_query.sh && cat output.txt"]

