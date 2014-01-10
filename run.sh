#!/bin/bash

trap "echo \"Sending SIGTERM to postgres\"; killall -s SIGTERM postgres" SIGTERM

/usr/local/bin/start_postgres.sh &

sleep 4

echo "Setting superuser password..."
/usr/local/bin/init_postgres.sh

wait $!

