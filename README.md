# Run postgrest on Heroku

Run [postgrest](https://github.com/begriffs/postgrest) on Heroku against Heroku Postgres itself. This uses my custom fork that adds support for `${DATABASE_URI}` and Basic Auth. See [this pull request](https://github.com/begriffs/postgrest/pull/191#issuecomment-100794067) for context.

## Deploying

Create a Heroku app with a Postgres addon, and then:

```
heroku docker:release --app myapp
```

You get a functional postgrest instance with HTTPs and basic auth (using same creds as Heroku postgres). 
