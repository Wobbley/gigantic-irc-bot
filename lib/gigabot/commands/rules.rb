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
              summary: 'Prints server info for the GGUnleashed Teamspeak, open for everyone',
              description: 'Prints server for of the GGUnleashed Teamspeak, open for everyone'

      listen_to :join, :method => :notify_rules

      def rules(m)
        m.target.send "Behave and check out the rules: #{URL}"
      end

      def notify_rules(m)
        m.target.notice("Behave and check out the rules: #{URL}")
      end
    end
  end
end