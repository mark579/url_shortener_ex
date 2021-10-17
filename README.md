# UrlShortenerEx

## Getting Started


To simply run the app you can use `docker-compose up`. 

Then open your browser and go to [http://localhost:5000](localhost:5000).

This requires you have both docker, and docker-compose installed.

### Development

To run locally and do development you will need. 

* Node Version 14
* Elixir 1.12.3
* Yarn 1.2 or Greater
* PostgreSQL

PosgreSQL will need to have a user configured which can create database, and tables. The user default for this repo is `postgres`

Once you have all dependencies installed. Install node modules. 

 `cd client && yarn install`

There is a Procfile you so you can use [goreman](https://github.com/mattn/goreman) or similar. Note: You will need to install GO for this. 

Otherwise you will need to start the frontend and backend seperately. 

Backend : 
* `mix deps.get`
* `mix phx.server`


Frontend: `cd client && yarn run start`

You will also need to set these environment variables then starting the backend.

* DATABASE_USER=postgres

* DATABASE_PASS=postgres

* DATABASE_NAME=url_shortener_ex_dev

* DATABASE_PORT=5432

* DATABASE_HOST=localhost

A nice way to do this is using [direnv](https://direnv.net/). Otherwise you can set in your profile or simply pass on the command line. 

### Tests & linting

CI Will check this and fail build if you do not use proper formatting and linting. To run the linting commands use what's listed below.  

#### Elixir

 * Test: `mix test`
 * Format: `mix format`

#### Frontend

* Test: `cd client && yarn run test`
* Lint: `cd client && yarn run eslint`
* Formatting: `yarn run prettier`


### CI

This repo has github actions setup that will run test and then build and publish corresponding docker images. 

