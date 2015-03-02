require 'rubygems'
require 'cinch'
require 'cinch/commands'
require 'twitter'
require 'shorturl'

module Gigabot
  module Commands
    class Twitter
      include Cinch::Plugin
      include Cinch::Commands

      def initialize(bot)
        super(bot)
        @client = create_client
        @follow = config[:follow]
        @channels = bot.config.channels
        @latest_tweets = Hash.new
        set_initial_tweets
      end

      timer 60, method: :twitter_update
      def twitter_update
        @follow.each do |user|
          new_tweet = @client.user_timeline(user, options = {exclude_replies: true}).first
          if @latest_tweets[user] != new_tweet
            short_url = ShortURL.shorten("https://twitter.com/#{user}/status/#{new_tweet.id}")
            reply = Format(:bold, "<#{user}> ") + "#{new_tweet.full_text} [#{short_url}]"
            reply = reply.gsub(/\n/,' ')

            @channels.each {|channel| Channel(channel).send(reply)}
            @latest_tweets[user] = new_tweet
          end
        end
      end


      private
      def create_client
        ::Twitter::REST::Client.new do |c|
          c.consumer_key        = config[:consumer_key]
          c.consumer_secret     = config[:consumer_secret]
          c.access_token        = config[:access_token]
          c.access_token_secret = config[:access_token_secret]
        end
      end

      def set_initial_tweets
         @follow.each do |user|
           @latest_tweets[user] = @client.user_timeline(user, options = {exclude_replies: true}).first
         end
      end
    end
  end
end