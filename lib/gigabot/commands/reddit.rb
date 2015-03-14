require 'rubygems'
require 'cinch'
require 'cinch/commands'

require 'redd'
require 'shorturl'

module Gigabot
  module Commands
    class Reddit
      include Cinch::Plugin
      include Cinch::Commands

      URL = 'http://www.reddit.com/'

      def initialize(bot)
        super(bot)
        @client = Redd.it(:userless, config[:client_id], config[:client_secret], user_agent: config[:user_agent])
        @following = config[:following]
        @channels = bot.config.channels
        @latest_activity = Hash.new
        set_initial_activity
      end

      timer 60, method: :reddit_update
      def reddit_update
        @following.each do |user|
          new_activity = get_latest_activity(user)
          if @latest_activity[user] != new_activity
            reply = format_by_instance(new_activity, user)

            send_message_to_channels(reply)
            @latest_activity[user] = new_activity
          end
        end
      end

      def format_by_instance(new_activity, user)
        if new_activity.instance_of? Redd::Objects::Comment
          short_url = ShortURL.shorten(new_activity.link_url)
          return Format(:bold, "<#{user}> ") + "commented on  '#{new_activity.link_title}' [#{short_url}])"
        end
        if new_activity.instance_of? Redd::Objects::Submission
          short_url = ShortURL.shorten(URL + new_activity.permalink)
          Format(:bold, "<#{user}> ") + "made a new submission with the title '#{new_activity.title}' [#{short_url}]"
        end
      end

      private
      def set_initial_activity
        @following.each do |user|
          @latest_activity[user] = get_latest_activity(user)
        end
      end

      private
      def get_latest_activity(user)
        @client.user_from_name(user).get_overview.first
      end

      private
      def send_message_to_channels(message)
        @channels.each {|channel| Channel(channel).send(message)}
      end
    end
  end
end

