# PostgreSQL
#
# VERSION               0.0.1

FROM      debian:sid
MAINTAINER Deni Bertovic "deni@kset.org"

# Credentials - !!CHANGE THIS!!
# This will be used as the password for the postgres user
ENV PG_SUPER_PASS password

ENV DEBIAN_FRONTEND noninteractive

ADD ACCC4CF8.asc /tmp/ACCC4CF8.asc
RUN apt-key add /tmp/ACCC4CF8.asc

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/postgresql.list

RUN apt-get -qq update
RUN apt-get -qq -y install locales
ADD locale.gen /etc/locale.gen

# Set a default language
RUN echo 'LANG="en_US.UTF-8"' > /etc/default/locale
RUN echo 'LANGUAGE="en_US:en"' >> /etc/default/locale
RUN locale-gen en_US.UTF-8
RUN update-locale en_US.UTF-8

RUN apt-get -qq -y upgrade

RUN apt-get -qq -y install postgresql-9.3 postgresql-contrib-9.3 postgresql-plpython-9.3

ADD start_postgres.sh /usr/local/bin/start_postgres.sh
ADD init_postgres.sh /usr/local/bin/init_postgres.sh
ADD run.sh /usr/local/bin/run.sh
RUN /bin/chmod 755 /usr/local/bin/start_postgres.sh
RUN /bin/chmod 755 /usr/local/bin/init_postgres.sh
RUN /bin/chmod 755 /usr/local/bin/run.sh

ADD pg_hba.conf     /etc/postgresql/9.3/main/
ADD pg_ident.conf   /etc/postgresql/9.3/main/
ADD postgresql.conf /etc/postgresql/9.3/main/

RUN chown -R postgres. /etc/postgresql/9.3/main/

EXPOSE 5432

CMD ["/usr/local/bin/run.sh"]

