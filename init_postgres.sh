#!/bin/bash

psql -Upostgres -c"ALTER USER postgres WITH PASSWORD '$PG_SUPER_PASS';"

