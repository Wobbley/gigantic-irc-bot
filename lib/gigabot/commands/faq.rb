require 'rubygems'
require 'cinch'
require 'cinch/commands'

module Gigabot
  module Commands
    class FAQ
      include Cinch::Plugin
      include Cinch::Commands

      command :faq, {},
              summary: 'Links the official Gigantic FAQ',
              description: 'Links the official Gigantic FAQ'
      command :faq, { username: :string },
              summary: 'Links the official Gigantic FAQ and highlights user',
              description: 'Links the official Gigantic FAQ'


      URL = 'http://www.gogigantic.com/explore/faq'

      def faq(m, username=nil)
        if username.nil?
          message = "The Alpha FAQ can be found here: #{URL}"
        else
          message = "You can find the Alpha FAQ here, #{username}: #{URL}"
        end

        m.target.send message
      end
    end
  end
end
