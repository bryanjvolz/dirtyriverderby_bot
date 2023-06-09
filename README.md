# Dirty River Derby Twitter Reply Bot

Ruby based Twitter reply bot for Heroku based on `https://www.johnpe.art/2017/01/16/its-you-twitter-bot`

Heroku deprecated the account type used in 2023 and the bot no longer runs from that environment. Will need to be moved to continue operation or for similar usage with another focus.

The Dirty River Derby is the 'real' name for the soccer rivalry between Louisville City FC and FC Cincinnati. `//www.dirtyriverderby.com/`

## Run the bot

### This bot runs automatically via the Scheduler addon but can be run manually with:
`heroku run ruby dirtyriverderbybot.rb`

### To run with Scheduler:
`ruby dirtyriverderbybot.rb`

### To Run Locally only:
`heroku local:run ruby dirtyriverderbybot.rb`

## To Manage Jobs:
`heroku addons:open scheduler` // `https://scheduler.heroku.com/dashboard`


## Deployment using Heroku:
`git push heroku master`

## Dependencies:
* Redis - keep track of twitter IDs already replied to in order to prevent spamming

## TODO:
* Put search terms into array for easier updating/porting for other uses
* Look into preventing replies to simple retweets
