
require 'ostruct'
require 'minitest/mock'

require File.dirname(__FILE__) + '/../../../helper'
require File.dirname(__FILE__) + '/../../../../lib/gigabot/commands/rules'

module Gigabot
  module Commands
    class RulesTest < Gigabot::TestCase

      def test_send_rules

        bot = Cinch::Bot.new
        bot.loggers.level = :fatal

        message = OpenStruct.new
        message.target = MiniTest::Mock.new
        message.target.expect :send, nil, ["Behave and check out the rules: #{Rules::URL}"]

      end

      def test_notify_rules_on_join
        bot = Cinch::Bot.new
        bot.loggers.level = :fatal

        message = OpenStruct.new
        message.user = MiniTest::Mock.new
        message.user.expect :notify, nil, ["Behave and check out the rules: #{Rules::URL}"]
      end
    end
  end
end

