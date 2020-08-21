#! /bin/sh

# If the database exists, migrate. Otherwise setup (create and migrate)
rails db:migrate 2>/dev/null || rails db:create db:migrate
echo "Done!"