#!/bin/bash

trap "echo \"Sending SIGTERM to postgres\"; killall -s SIGTERM postgres" SIGTERM

/usr/local/bin/start_postgres.sh &

echo
echo "Please wait while we set the postgres user password..."
echo

sleep 5

echo
echo "Setting superuser password..."
/usr/local/bin/init_postgres.sh
echo
echo "Success..."

wait $!

