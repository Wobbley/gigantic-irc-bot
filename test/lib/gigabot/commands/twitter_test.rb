require 'minitest/unit'
require 'mocha/mini_test'


require File.dirname(__FILE__) + '/../../../helper'
require File.dirname(__FILE__) + '/../../../../lib/gigabot/commands/twitter'

module Gigabot
  module Commands
    class TwitterTest < TestCase

      def setup
        bot = Cinch::Bot.new
        bot.loggers.level = :fatal

        bot.config.plugins.options[Twitter] = {
            consumer_key: 'test_key',
            consumer_secret: 'test_key_secret',
            access_token: 'test_access_token',
            access_token_secret: 'test_access_token_secret',
            follow: %w(twitter_follow1 twitter_follow2)
        }

        args = { id: 573536452149182464, id_str: 73536452149182464, text: 'This is an initial tweet from the user'}
        @initial_tweet = ::Twitter::Tweet.new(args)

        Twitter.any_instance.stubs(:get_latest_tweet).returns(@initial_tweet)
        Twitter.stubs(:send_message_to_channels)
        Twitter.stubs(:create_url).returns('http://url.com/rs1d21')
        @plugin = Twitter.new(bot)

      end

      def test_create_twitter_client_on_initialize
        refute_nil(@plugin.instance_variable_get(:@client))
      end

      def test_initial_tweets_are_set
        tweets = @plugin.instance_variable_get(:@latest_tweets)
        assert_equal(@initial_tweet, tweets['twitter_follow1'])
        assert_equal(@initial_tweet, tweets['twitter_follow2'])
      end

      def test_new_tweets_are_sent_to_channel
        args = { id: 573566452149285464, id_str: 573566452149285464, text: 'This is a new tweet from the user'}
        new_tweet= ::Twitter::Tweet.new(args)
        @plugin.stubs(:get_latest_tweet).returns(new_tweet)

        @plugin.expects(:send_message_to_channels).times(2)

        @plugin.twitter_update
      end

      def test_new_tweets_are_set_to_latest
        args = { id: 573566452149285464, id_str: 573566452149285464, text: 'This is a new tweet from the user'}
        new_tweet= ::Twitter::Tweet.new(args)
        @plugin.stubs(:get_latest_tweet).returns(new_tweet)

        @plugin.twitter_update

        tweets = @plugin.instance_variable_get(:@latest_tweets)
        assert_equal(new_tweet, tweets['twitter_follow1'])
        assert_equal(new_tweet, tweets['twitter_follow2'])
      end

    end
  end
end
