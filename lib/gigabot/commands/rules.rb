require 'rubygems'
require 'cinch'
require 'cinch/commands'

module Gigabot
  module Commands
    class Rules
      include Cinch::Plugin
      include Cinch::Commands

      URL = 'http://ggunleashed.com/Gigantic/chat/'

      command :rules, {},
              summary: 'Links to the server rules for the IRC channel',
              description: 'Links to the server rules for the IRC channel'

      listen_to :join, :method => :notify_rules

      def rules(m)
        m.user.send "Behave and check out the rules: #{URL}"
      end

      def notify_rules(m)
        m.user.notice("Behave and check out the rules: #{URL}")
      end
    end
  end
end