# Vinyl Models

***

Project for my learning purposes only. If you stumbled here looking for meaning of life, I'm afraid you're in the wrong place. (I have it on good authority that it's 42.)

## Technical Aim

- To create a database and host it on a cloud
    - To learn SQL migrations
    - To learn local testing via docker
- To create pythonic ORM (SQLAlchemy) models that will allow easier interaction with the database
- To write tests to validate both the DB setup as well as the models
- To enable CI/CD pipeline for the project
- To learn what exacltly is RESTful API and apply it here

## Non-Technical Aim?

This is the first repo in series of Vinyl Value Vault project. This is the backend of the project providing database of vinyl records in my collection along with pricing information and market information. It adds API on top to allow for easy interaction with the data.

# Database

***

Platform of choice is [Supabase](https://supabase.com/). It's a PostgreSQL database with a free tier that's easy to set up and has a nice UI. It masks a lot of the complexity and provides a nice CLI tool with which you can interact quite easily both locally and on GitHub CI pipeline. 

## SQL Migrations

Those are managed by Supabase directly. In a project repo:
> supabase migration new "migration_name"

Upon local or remote DB update Supabase keeps tracks of already applied migrations and only applies new ones. Neat! For human readbility I have adopted VX.X.X versioning style on top of datetime enforced by Supabase.

Good docs on migrations are [here](https://supabase.com/docs/guides/deployment/database-migrations)

# ORM Models

For that I have chosen SQLAlchemy, since I already know it a little from work. This is a fairly simple tool to use, but it is somewhat frustrating that it requires you to double yur DB definition - once in SQL migrations and then to be reproduced in python models. Here is an idea for a future project...

# Tests

***

Using pytest. Only 'obstacle' here was testing with docker for the first time. Supabase does provide its own CLI tool for testing - however that only tests the DB setup itself. It basically executes SQL queries on seeded data and checks for the output. This is handy indeed... Good unit tests.

I am lazy and don't want to first test the SQL and then Python. I am just doing it all at once and reading the error message, likely it will have good info to tell you if its your SQL or Python that it broken. 

Again, when deploying migrations locally, supabase seeds the DB with your script as well so the data is available for pytest to pick up. Then using a few fixtures I am connecting to the local DB running in a docker container and I am querying it using my SQLAlchemy models. Two birds one stone.

# CI/CD

***

Now that was tricky. I have three GitHub Actions workflows:
- one for basic validation on the Pull Request
    - check dependencies are all valid
    - check version in `__init__.py` 
    - lint python and SQL
    - run tests
    - build
    - deploy to `test.pypi`
- one for Supabase migrations to remote when merging
- one for package deployment to `pypi` when merging

God bless DevOps engineerings for making this easier in a workplace. The setup I have is very crude, and I fear the day when I will have to open up new repo and run the setup again. Another proejct idea for the future: create template repos for future projects...

# RESTful API

***

WiP