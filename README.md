# Pokedex.io

[![RSpec](https://github.com/joemsak/pokedex.io/actions/workflows/rspec.yml/badge.svg)](https://github.com/joemsak/pokedex.io/actions/workflows/rspec.yml)

## Pitch

[https://docs.google.com/document/d/1oO2BT4BThVz0n6ibe-mmDpWimX9EU7CcTrRzY6SXwl8/edit?usp=sharing](https://docs.google.com/document/d/1oO2BT4BThVz0n6ibe-mmDpWimX9EU7CcTrRzY6SXwl8/edit?usp=sharing)

## Prerequisites

* Docker
* Docker Compose
* Dip (optional)
  * https://github.com/bibendi/dip

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
dip rails assets:precompile RAILS_ENV=test # AS NEEDED
dip rails webpacker:compile RAILS_ENV=test # AS NEEDED

dip rspec

# Without
RAILS_ENV=test docker-compose run web bundle exec rails assets:precompile # AS NEEDED
RAILS_ENV=test docker-compose run web bundle exec rails webpacker:compile # AS NEEDED

RAILS_ENV=test docker-compose run web bundle exec rspec
```
