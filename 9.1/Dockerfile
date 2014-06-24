# PostgreSQL 9.1
#
# VERSION               0.0.2

FROM      debian:wheezy
MAINTAINER Deni Bertovic "me@denibertovic.com"

# Credentials - !!CHANGE THIS!!
# This will be used as the password for the postgres user
ENV PG_SUPER_PASS password

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update
RUN apt-get -qq -y install locales
ADD locale.gen /etc/locale.gen

# Set a default language
RUN echo 'LANG="en_US.UTF-8"' > /etc/default/locale
RUN echo 'LANGUAGE="en_US:en"' >> /etc/default/locale
RUN locale-gen en_US.UTF-8
RUN update-locale en_US.UTF-8

RUN apt-get -qq -y install postgresql-9.1 postgresql-client-9.1 postgresql-contrib-9.1 \
    postgresql-plpython-9.1 postgresql-plperl-9.1 postgresql-9.1-postgis \
    postgresql-9.1-ip4r

ADD start_postgres.sh /usr/local/bin/start_postgres.sh
RUN /bin/chmod 755 /usr/local/bin/start_postgres.sh

ADD certs/server.crt /etc/postgresql/9.1/main/
ADD certs/server.key /etc/postgresql/9.1/main/

ADD pg_hba.conf     /etc/postgresql/9.1/main/
ADD pg_ident.conf   /etc/postgresql/9.1/main/
ADD postgresql.conf /etc/postgresql/9.1/main/

RUN /bin/chown -R postgres. /etc/postgresql/9.1/main/
RUN /bin/chmod 600 /etc/postgresql/9.1/main/server.key

# Set required sysctl params and alter Postgres user password
RUN     /etc/init.d/postgresql start &&\
        psql -Upostgres -Upostgres -c"ALTER USER postgres WITH PASSWORD '$PG_SUPER_PASS';"

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

EXPOSE 5432

CMD ["/usr/local/bin/start_postgres.sh"]
