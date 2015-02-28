require 'rubygems'
require 'cinch'
require 'cinch/commands'

module Gigabot
  module Commands
    class Bug
      include Cinch::Plugin
      include Cinch::Commands

      command :bug, {},
              aliases: [ :feature, :issue],
              summary: "Submit an issue to the bot's tracker",
              description: "Submit an issue to the bot's  tracker"

      URL = 'https://github.com/Wobbley/gigantic-irc-bot/issues/new'

      def bug(m)
        m.target.send("You can submit an issue to the bots tracker here: #{URL}")
      end
    end
  end
end