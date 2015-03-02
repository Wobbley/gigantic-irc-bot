=begin
#TODO: Figure out how to test twitter
require 'minitest/mock'

require File.dirname(__FILE__) + '/../../../helper'
require File.dirname(__FILE__) + '/../../../../lib/gigabot/commands/twitter'

module Gigabot
  module Commands
    class TwitterTest < TestCase
      def setup
        bot = Cinch::Bot.new
        bot.loggers.level = :fatal

        bot.config.plugins.options[Twitter] = {
            consumer_key: 'test_key',
            consumer_secret: 'test_key_secret',
            access_token: 'test_access_token',
            access_token_secret: 'test_access_token_secret',
            follow: %w(follow1 follow2)
        }

        #@plugin = Twitter.new(bot)

      end

      ##TODO Is there a way to check if a method has been called?
      def test_create_twitter_client_on_initialize
        refute_nil(@plugin.instance_variable_get(:@client))
      end

    end
  end
end
=end