require 'rubygems'
require 'cinch'

require File.dirname(__FILE__) + '/commands/twitter'
require File.dirname(__FILE__) + '/commands/faq'
require File.dirname(__FILE__) + '/commands/teamspeak'
require File.dirname(__FILE__) + '/commands/help'

module Gigabot
  class BotFactory
    def self.from_config(configuration)
      check_missing_config(configuration)

      Cinch::Bot.new do
        configure do |c|
          c.server = configuration.irc.server
          c.channels = configuration.irc.channels
          c.nick = configuration.irc.nick
          c.messages_per_second = 1
          c.server_queue_size = 20
          c.plugins.plugins = [
              Commands::Twitter,
              Commands::FAQ,
              Commands::Teamspeak,
              Commands::Help,
              Commands::Bug
          ]

          c.plugins.options[Commands::Twitter] = {
              consumer_key: configuration.twitter.consumer_key,
              consumer_secret: configuration.twitter.consumer_secret,
              access_token: configuration.twitter.access_token,
              access_token_secret: configuration.twitter.access_token_secret,
              follow: configuration.twitter.follow,
          }

        end
      end
    end

    private
    def self.check_missing_config(configuration)
      raise 'Config file required' if configuration.irc.nil?

      required_config = {
          server: 'Server is required',
          channels: 'At least one channel is required',
          nick: 'Nick is required'
      }

      required_config.each_pair do |key, message|
        raise message if configuration.irc[key].nil?
      end
    end
  end
end