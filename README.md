# PostgreSQL Dockerfile

Available versions: 9.1, 9.2 and 9.3


Clone the repo

    git clone https://github.com/denibertovic/postgresql-dockerfile

Build

    cd 9.3/
    docker build -t postgres:9.3 .

Or pull from the index:

    docker pull denibertovic/postgres:9.3


Run it:
    
    docker run -p 5432:5432 -i denibertovic/postgres:9.3


Test it (the default password is 'password'):

    psql -Upostgres -h localhost


### Evironment Variables in Dockerfile:

Password used for Postgres superuser (*change this*):

    ENV PG_SUPER_PASS

