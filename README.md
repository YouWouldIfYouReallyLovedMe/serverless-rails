# README

## Localdev Setup

* Create github account
* Set up SSH keys to push
* In the repo, `git config user.email` and `user.name`
* Populate git secrets with AWS credentials
* Set up ECS Github action
  * Copy `.github/workflows/aws.yml`

Populate an .env file as such;

```
DATABASE_URL=postgres://postgres@postgres
```

*To create a local postgres instance*
```
brew install postgres
brew services [start/stop/restart] postgresql
createdb
psql
> create role postgres with createdb login password 'password';
rake db:setup
```

*To build and run the Docker image*
```
docker build . -t serverless-rails:latest
docker-compose up
docker-compose run rails rake db:create db:migrate
```

*To connect to the postgres instance*
```
docker exec -it serverless-rails_postgres_1 psql -U postgres
```

## Testing

## In Production

* To manage ENV, we have to change the task definition [here](https://us-east-2.console.aws.amazon.com/ecs/home?region=us-east-2#/taskDefinitions) and then push a new branch

## TODO:
* Migrate this repo to one owned by an organization
  * Set up CODEOWNERS on that organization
* Invite the rest of the team to that + AWS
* Tighten up security around which service account pushes/deploys the new ECS instances
* Set up staging infrastructure
