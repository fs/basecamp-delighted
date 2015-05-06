## Basecamp -> Delighted

This is a small app for getting clients from Basecamp's active projects and putting them into Delighted survey service.

## How it works
If you familiar with Ruby:

1. Clone repo to the local machine: `$ git clone git@github.com:fs/basecamp-delighted.git`.
2. Change directory: `$ cd basecamp-delighted`.
3. Resolve dependencies: `$ bundle install`.
4. Create `.env` file and populate it with key-value pairs ([example .env file](#user-content-env-example))
5. Run app: `$ APP_ENV=development bin/main`.
6. Check Delighted service.

Otherwise you can use [Heroku](http://www.heroku.com) as platform for running this app:

1. Clone repo to the local machine: `$ git clone git@github.com:fs/basecamp-delighted.git`.
2. Change directory: `$ cd basecamp-delighted`.
3. [Create account](https://id.heroku.com/signup/login) on Heroku.
4. Download and install the [Heroku Toolbet](https://toolbelt.heroku.com/).
5. If you haven't already, log in to your Heroku account and follow the prompts to create a new SSH public key: `$ heroku login`.
6. Create new app: `$ heroku apps:create app_name`. You can omit `app_name` and Heroku creates app with default name.
7. Deploy your app: `$ git push heroku master`.
8. Populate config variables on `settings` tab as it's done in the [example .env file](#user-content-env-example).
9. Run app: `$ heroku run bin/main --app app_name`.
10. Check Delighted service.

## .ENV example

```ruby
# .env

# Basecamp credentials
BC_USER=user@example.com
BC_PASSWORD=user_pass
BC_APP="your_app_name (user@example.com)"
BC_ACCOUNT_ID=9999999

# Delighted credentials
DELIGHTED_API_KEY=5SLQLx5R47peQq2F87GbP6BskEuCMDWD
DELIGHTED_DELAY=3600
```

* `BC_USER/BC_PASSWORD` - credentials of Basecamp's user that have access to projects.
* `BC_APP` - point here your email. Reason described [here](https://github.com/basecamp/bcx-api/#identify-your-app).
* `BC_ACCOUNT_ID` - Basecamp account's id. When you logged in Basecamp, take a look at URL, it looks like: https://basecamp.com/1787128, digits after slash is account id.
* `DELIGHTED_API_KEY` - API key can be found on account [API page](https://delighted.com/account/api)
* `DELIGHTED_DELAY` - delay **in seconds** before surveys will be sent to just added peoples.
