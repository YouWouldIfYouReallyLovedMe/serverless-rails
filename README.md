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
POSTGRES_DB=serverless_rails_development
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

## TODO:
 * Set up CD
 * Serverless
