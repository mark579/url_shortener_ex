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

Once you have all dependencies installed. Install node modules. 

 `cd client && yarn install`

There is a Procfile you so you can use [goreman](https://github.com/mattn/goreman) or similar. Note: You will need to install GO for this. 

Otherwise you will need to start the frontend and backend seperately. 

Backend : `mix phx.server`

Frontend: `cd client && yarn run start`

You will also need to set these environment variables then starting the backend.

* DATABASE_USER=postgres

* DATABASE_PASS=postgres

* DATABASE_NAME=url_shortener_ex_dev

* DATABASE_PORT=5432

* DATABASE_HOST=localhost

A nice way to do this is using [direnv](https://direnv.net/). Otherwise you can set in your profile or simply pass on the command line. 

### Tests

To run tests, once you have your development environment setup you can run. 

Backend: `mix test`
Frontend: `cd client && yarn run test`