FROM mariadb:10.11.8

ADD --chown=root:root ./custom-mariadb.cnf /etc/mysql/mariadb.conf.d/custom-mariadb.cnf

RUN apt-get update && apt-get install -y jq && rm -rf /var/lib/apt/lists/*

# Rewrite the entrypoint
COPY docker-entrypoint.sh /usr/local/bin/

# Copy the restore script
COPY restore.sh /

# Make the script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh