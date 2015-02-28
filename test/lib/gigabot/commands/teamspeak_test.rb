
require 'ostruct'
require 'minitest/mock'

require File.dirname(__FILE__) + '/../../../helper'
require File.dirname(__FILE__) + '/../../../../lib/gigabot/commands/teamspeak'

module Gigabot
  module Commands
    class TSTest < Gigabot::TestCase

      def test_send_ts_address

        bot = Cinch::Bot.new
        bot.loggers.level = :fatal

        message = OpenStruct.new
        message.target = MiniTest::Mock.new
        message.target.expect :send, nil, ["The GGUnleashed community server can be found here: #{Teamspeak::URL}"]

      end
    end
  end
end

