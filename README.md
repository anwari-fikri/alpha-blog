# First things first
1. Change the Ruby version in the "Gemfile" to your current Ruby version (Ruby version: 2.7.3 is recommended)

2. Make sure Gemfile.lock is empty

# Docker
Commands are referred from https://docs.docker.com/samples/rails/

## Run these commands
docker compose run --no-deps web rails new . --force --database=postgresql

docker compose up --build

## Then in another terminal
docker compose run web rake db:create
