# Gigantic IRC Bot

## Code status

## Run
* Get sources
* Copy `config.yml.dist` to `config.yml` and edit it with your configuration
* Install dependencies with [bundler](http://bundler.io/) (`bundle install`)
* Run the bot: `bundle exec rake run`

## Bot features

###Commands
* !faq - Links the official Gigantic Alpha FAQ
* !faq :username - Links the official Gigantic Alpha FAQ and highlights user
* !ts - Prints server info for the GGUnleashed Teamspeak, open for everyone
* !help - Lists available commands
* !help :command - Displays help information for the command
* !bug - Submit an issue to the bot's tracker
* !twitch - Links tracked Gigantic streams that are online
* !twitch :username - Links the user if online and streaming gigantic
* !seen :username - Retrieves last seen time and comment in the channel from the user
* !memo for :username: :message - Leaves a message for the user when he comes online
* !memo for :username: :message - Leaves a private message for the user only delivers when user authenticates(when messaging the bot)

###Features
* Announces when tracked Twitch users comes online
* Retrieves stream information when a twitch stream is linked (streamer name, title, and game)
* Announces when tracked Twitter accounts make posts (ignoring replies or retweets)
* Links when new threads are created by tracked Reddit users
* Links when new comments are made by tracked Reddit users
* Sends a notice about channel rules to the joining user
* Posts link titles for selected domains (currently only youtube, and imgur)

##Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
