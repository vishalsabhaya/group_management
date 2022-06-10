# Top Score Ranking

This application only implemented APIs, will be used to manage a group of Company.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine with Docker for development and testing purposes.

### Prerequisites

* Ruby version

  - Ruby-3.1.2

* Rails vesrion

  - Rails-7.0.3

* Testing framework
  - RSpec

# Installation

 1. [Manual](#manual)
 2. [With Docker](#with-docker)

A step by step series of examples that tell you how to get a development env running.

## Manual

- Clone this repository

```
$ git clone https://github.com/vishalsabhaya/group_management.git
```

- Install a compatible version of PostgreSQL

```
$ brew install postgresql@14.3
```

- Move to the `group_management` directory from your terminal

```
$ cd group_management
```

- Initialize a new gemset (if using RVM) then install bundler

```
$ gem install bundler
```

- Install the application dependencies

```
$ bundle install
```

#### Database Configuration

*PostgreSQL* used as database for this application.
> Make sure PostgreSQL is installed in your machine and you have setup the  `database.yml` file correctly

- Database creation

```
$ bundle exec rails db:create
```

- Tables migration and preparing for tests

```
$ bundle exec rails db:migrate
$ bundle exec rails db:test:prepare
```

- check the *db/schema.rb* after migration completed successfully

#### Running Tests

Test cases written using *RSpec*

Run test cases using this command

```
$ bundle exec rspec
```

All the tests should be *GREEN* to pass all test cases

#### Running Application

- Starting application

> Make sure you are in the application folder and already installed application dependencies

```
$ rails server
```

- Check the application on browser, open the any browser of your choice and hit the following in the browser url *http://localhost:3000/*

> Make sure server listen on port 3000

```
localhost:3000
```

## With Docker

- Build and start Docker
> Make sure you are in the application folder and already installed [Docker](https://docs.docker.com/get-docker/) & [Docker Compose](https://docs.docker.com/compose/install/) in your machine.

```
$  make docker_build
```

- Checking *Images* is running or not

```
$ docker-compose ps

Result should be like this

NAME                     COMMAND                  SERVICE             STATUS              PORTS
----------------------------------------------------------------------------------------------------
group_management-app-1   "bash -c 'bundle exe…"   app                 running             3000/tcp
group_management-db-1    "docker-entrypoint.s…"   db                  running             0.0.0.0:5432->5432/tcp
group_management-web-1   "/docker-entrypoint.…"   web                 running             0.0.0.0:80->80/tcp
```

- Database creation & migration

```
$ docker-compose exec app bundle exec rails db:setup
```

#### Running Tests

Run test cases in docker image using this command

```
$ docker-compose exec app bundle exec rspec
```

## APIs documentation with [Postman](https://www.postman.com/)

- [Documentation](https://documenter.getpostman.com/view/17581673/Uz5NhsV2)

## Author

* **Vishal Sabhaya** - [GitHub profile](https://github.com/vishalsabhaya)
