require 'rubygems'
require 'cinch'
require 'cinch/commands'

module Gigabot
  module Commands
    class Teamspeak
      include Cinch::Plugin
      include Cinch::Commands

      URL = 'ts3server://ts.ggunleashed.com'

      command :ts, {},
              aliases: [ :ts3 ],
              summary: 'Prints server info for the GGUnleashed Teamspeak, open for everyone',
              description: 'Prints server for of the GGUnleashed Teamspeak, open for everyone'

      def ts(m)
        m.target.send "The GGUnleashed community server can be found here: #{URL}"
      end
    end
  end
end