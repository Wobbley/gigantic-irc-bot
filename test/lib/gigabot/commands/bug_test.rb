require 'ostruct'
require 'minitest/mock'

require File.dirname(__FILE__) + '/../../../helper'
require File.dirname(__FILE__) + '/../../../../lib/gigabot/commands/bug'

module Gigabot
  module Commands
    class BugTest < Gigabot::TestCase
      def test_send_ts_address
        bot = Cinch::Bot.new
        bot.loggers.level = :fatal

        plugin = Bug.new(bot)

        message = OpenStruct.new
        message.target = MiniTest::Mock.new
        message.target.expect :send, nil, ["You can submit an issue to the bots tracker here: #{Bug::URL}"]

        plugin.bug(message)

        message.target.verify
      end
    end
  end
end
