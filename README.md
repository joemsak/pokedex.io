# Pokedex.io

## Prerequisites

* Docker
* Docker Compose
* Dip (optional)
* * https://github.com/bibendi/dip

## Setup / Install

```
git clone git@github.com:joemsak/pokedex.io.git
cd pokedex.io
```

```
# With Dip
dip provision

# Without
docker-compose build
docker-compose up -d db 
docker-compose run web ./bin/setup
```

## Running the app

```
# With Dip
dip up -d webpack sidekiq
dip up web

# Without
docker-compose up -d sidekiq webpack
docker-compose up web
```

## Migrations

```
# With Dip
dip rails db:migrate (rollback, drop, create, reset, etc)

# Without
docker-compose run web rails db:migrate
```

## Run tests

```
# With Dip
dip rspec

# Without
RAILS_ENV=test docker-compose run web bundle exec rspec
```
