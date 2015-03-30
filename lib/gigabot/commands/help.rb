require 'rubygems'
require 'cinch'
require 'cinch/commands'

module Gigabot
  module Commands
    class Help < Cinch::Commands::Help
      include Cinch::Commands

      command :help, {command: :string},
              summary: 'Displays help information for the :command',
              description: 'Finds the :command and prints the usage and description for the :command.'

      command :help, {},
              summary: 'Lists available commands',
              description: 'If no :command argument is given, then all commands will be listed.',
              aliases: [:commands, :assist]

      # override the method to send help to the user only
      def help(m,command=nil)
        return each_command { |cmd| m.user.send "!#{cmd.usage} - #{cmd.summary}" } unless command

        found = commands_named(command)

        return m.user.send "help: Unknown command #{command.dump}" if found.empty?

        send_help_to_user(found, m)
      end

      def send_help_to_user(found, m)
        found.each { |cmd| m.user.send "!#{cmd.usage}" }
        m.user.send ''
        m.user.send found.first.description
      end

    end
  end
end