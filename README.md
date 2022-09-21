Honestly this project is broken and is a big one for me and i don't know how to jump back in LOL. but im just gonna leave the repository here.

# Docker
Commands are referred from https://docs.docker.com/samples/rails/

## Run these commands
docker compose run --no-deps web rails new . --force --database=postgresql

docker compose up --build

## Then in another terminal
docker compose run web rake db:create
