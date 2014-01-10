# PostgreSQL
#
# VERSION               0.0.1

FROM      ubuntu:12.04
MAINTAINER Deni Bertovic "deni@kset.org"

# Credentials
ENV PG_SUPER_PASS docker

# Make sure that Upstart won't try to start RabbitMQ after apt-get installs it
# https://github.com/dotcloud/docker/issues/446
ADD policy-rc.d /usr/sbin/policy-rc.d
RUN /bin/chmod 755 /usr/sbin/policy-rc.d

# Another way to work around Upstart problems
# https://www.nesono.com/node/368
# RUN dpkg-divert --local --rename --add /sbin/initctl
# RUN ln -s /bin/true /sbin/initctl

RUN locale-gen en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

ADD ACCC4CF8.asc /tmp/ACCC4CF8.asc
RUN apt-key add /tmp/ACCC4CF8.asc

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/postgresql.list
ADD locale /etc/default/locale
RUN apt-get -qq update
RUN apt-get -qq -y install postgresql-9.3 postgresql-contrib-9.3

EXPOSE 5432

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

CMD ["/usr/local/bin/run.sh"]

