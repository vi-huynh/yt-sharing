### Guidelines

## Prerequisites: 
* Ruby version 3.2.2 
* Rails version 7.0
* Redis 
* Postgres  

## Installation & Configuration: 

1. Clone the git repository

`git clone git@github.com:vi-huynh/yt-sharing.git`

2. Install Docker version 24.0.5

[https://docs.docker.com/engine/install/ ](https://docs.docker.com/engine/install/ )

3. Installing dependencies 

* Create .env file in root project 

```
PG_HOST=db
PG_USERNAME=postgres
PG_PASSWORD=password 

REDIS_SERVER=redis
CABLE_REDIS_URL=redis://redis:6379/2

# JWT CONFIG
JWT_ACCESS_PRIVATE_KEY=ACCESS_SECRET_KEY_YT_SHARING
JWT_REFRESH_PRIVATE_KEY=REFRESH_SECRET_KEY_YT_SHARING

# CORS
ALLOW_CORS_DOMAIN=localhost:3000,localhost:3001

```

* Build docker image

```docker compose build```

* Database Setup: 

```
1. $ docker compose run web rails db:create 

2. $ docker compose run web rails db:migrate 

3. $ docker compose run web rails db:seed
```

* Running the Application: 
```
1. How to start the development server
$ docker compose up --build

2. Access the application in a web browser 
 http://localhost:3000

3. Run the test suite.
$ docker compose run web rspec
```

