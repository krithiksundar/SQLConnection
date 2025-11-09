FROM container-registry.oracle.com/database/instantclient:21.11

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y sqlplus && \
    chmod +x run_query.sh

CMD ["bash", "run_query.sh"]
