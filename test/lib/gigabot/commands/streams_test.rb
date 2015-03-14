require 'minitest/unit'
require 'mocha/mini_test'

require File.dirname(__FILE__) + '/../../../helper'
require File.dirname(__FILE__) + '/../../../../lib/gigabot/commands/streams'

module Gigabot
  module Commands
    class StreamsTest < TestCase

      def setup
        bot = Cinch::Bot.new
        bot.loggers.level = :fatal

        bot.plugins.options[Commands::Streams] = {
            streamers: configuration.twitch.streamers
        }

        Streams.any_instance.stubs(:get_gigantic_streams).returns(nil)

        @plugin = Streams.new(bot)

      end

    end
  end
end
