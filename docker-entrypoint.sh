#!/bin/bash
set -e

# Prepare the database
./bin/rails db:prepare

# Start the server
exec ./bin/rails server -b 0.0.0.0 -p 3000
