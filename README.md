# Sveglia

A countdown timer app.

## Build Status [![Build Status](https://secure.travis-ci.org/hackatron/sveglia.png?branch=master)](http://travis-ci.org/hackatron/sveglia)

## Production environment configuration

Set production environment

```bash
$ heroku config:add GOLIATH_ENV=production
```

Set production Pusher's configuration

```bash
$ heroku config:add PUSHER_APP_ID=app_id PUSHER_KEY=key PUSHER_SECRET=secret
```

replacing `app_id`, `key` and `secret` with your app's configuration details.

## Notes

To start app server run

```bash
$ GOLIATH_ENV=development foreman start
```

If it doesn't work maybe you should install `foreman`

```bash
$ gem install foreman
```

To start console run

```bash
$ bundle exec irb -r ./sveglia.rb
```

To run specs

```bash
$ rake spec
```

To run jasmine specs

```bash
$ rake jasmine:ci
```

Repo for this project adopts [*git flow* branching model](http://nvie.com/posts/a-successful-git-branching-model/).