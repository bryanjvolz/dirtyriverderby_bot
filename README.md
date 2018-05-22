# Dirty River Derby Twitter Reply Bot

Ruby based Twitter reply bot for Heroku based on `https://www.johnpe.art/2017/01/16/its-you-twitter-bot`

This bot runs automatically via the Scheduler addon but can be run manually with `heroku run ruby dirtyriverderbybot.rb`

## To Manage Jobs:
`heroku addons:open scheduler` // `https://scheduler.heroku.com/dashboard`

## Deployment:
`git push heroku master`