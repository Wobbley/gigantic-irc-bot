require 'ostruct'
require 'minitest/mock'

require File.dirname(__FILE__) + '/../../../helper'
require File.dirname(__FILE__) + '/../../../../lib/gigabot/commands/faq'

module Gigabot
  module Commands
    class FAQTest < TestCase
      def setup
        bot = Cinch::Bot.new
        bot.loggers.level = :fatal

        @plugin = FAQ.new(bot)
      end

      def test_send_faq
        message = OpenStruct.new
        message.target = MiniTest::Mock.new
        message.target.expect :send, nil, ["The Alpha FAQ can be found here: #{FAQ::URL}"]

        @plugin.faq(message)

        message.target.verify
      end

      def test_send_faq_with_user_highlight
        username = 'foo'
        message = OpenStruct.new
        message.target = MiniTest::Mock.new
        message.target.expect :send, nil, ["You can find the Alpha FAQ here, #{username}: #{FAQ::URL}"]

        @plugin.faq(message, username)

        message.target.verify
      end
    end
  end
end