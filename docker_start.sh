#!/bin/sh
# Wait until Postgres is ready before running the next step.
while ! pg_isready -q -h $DATABASE_HOST -p $DATABASE_PORT -U $DATABASE_USER
do
  echo "$(date) - waiting for database to start."
  sleep 2
done

# Run create, it will skip if already exists
mix ecto.create
echo "Database $DATABASE_NAME created."

# Runs migrations, will skip if migrations are up to date.
echo "Database $DATABASE_NAME exists, running migrations..."
mix ecto.migrate
echo "Migrations finished."

# Start the server.
echo "Starting Server go to http://localhost:5000 to shorten URLS"
exec mix phx.server