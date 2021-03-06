require 'rubygems'
require 'cinch'
require 'cinch/plugins/identify'
require 'cinch/plugins/last_seen'
require 'cinch/plugins/links-titles'

require 'fileutils'

require File.dirname(__FILE__) + '/commands/twitter'
require File.dirname(__FILE__) + '/commands/faq'
require File.dirname(__FILE__) + '/commands/teamspeak'
require File.dirname(__FILE__) + '/commands/help'
require File.dirname(__FILE__) + '/commands/bug'
require File.dirname(__FILE__) + '/commands/reddit'
require File.dirname(__FILE__) + '/commands/rules'
require File.dirname(__FILE__) + '/commands/streams'

require File.dirname(__FILE__) + '/../../lib/cinch/plugins/memo'
require File.dirname(__FILE__) + '/../../lib/cinch/plugins/links-titles'

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
              Commands::Bug,
              Commands::Reddit,
              Commands::Rules,
              Commands::Streams,
              Cinch::Plugins::LastSeen,
              Cinch::Memo,
              Cinch::Plugins::LinksTitles
          ]

          unless configuration.irc.password.nil?
            c.plugins.plugins.push Cinch::Plugins::Identify
            c.plugins.options[Cinch::Plugins::Identify] = {
                username: configuration.irc.nick,
                password: configuration.irc.password,
                type: :nickserv,
                service_name: 'NickServ@services.globalgamers.net'
            }
          end

          c.plugins.options[Commands::Twitter] = {
              consumer_key: configuration.twitter.consumer_key,
              consumer_secret: configuration.twitter.consumer_secret,
              access_token: configuration.twitter.access_token,
              access_token_secret: configuration.twitter.access_token_secret,
              follow: configuration.twitter.follow,
          }

          c.plugins.options[Commands::Reddit] = {
              client_id: configuration.reddit.client_id,
              client_secret: configuration.reddit.client_secret,
              user_agent: configuration.reddit.user_agent,
              following: configuration.reddit.following
          }

          c.plugins.options[Commands::Streams] = {
              streamers: configuration.twitch.streamers
          }

          c.plugins.options[Cinch::Memo] = {
              :max_lifetime => 100
          }

          c.plugins.options[Cinch::Plugins::LinksTitles] = {
              :filename  => 'links-titles.yaml',
              :whitelist => %w(youtube imgur)
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