require 'minitest/unit'
require 'mocha/mini_test'


require File.dirname(__FILE__) + '/../../../helper'
require File.dirname(__FILE__) + '/../../../../lib/gigabot/commands/reddit'

module Gigabot
  module Commands
    class RedditTest < TestCase

      def setup
        bot = Cinch::Bot.new
        bot.loggers.level = :fatal

        bot.config.plugins.options[Reddit] = {
            client_id: 'test_id',
            client_secret: 'test_secret',
            user_agent: 'test_agent',
            following: %w(reddit_follow1 reddit_follow2)
        }

        attributes = {
            id: 'cp5k0lg',
            kind: 't1',
            name: 't1_cp5k0lg',
            author: 'MO_Kaboom',
            body: 'This is the comment body',
            link_title: 'This is the thread title',
            link_url: 'http://www.reddit.com/r/gigantic/comments/2xyxpc/a_request_to_anyone_going_to_pax_east/',
        }

        @initial_activity = ::Redd::Objects::Comment.new(nil, attributes)
        Reddit.any_instance.stubs(:get_latest_activity).returns(@initial_activity)

        @plugin = Reddit.new(bot)
        
      end

      def test_create_reddit_client_on_initialize
        refute_nil(@plugin.instance_variable_get(:@client))
      end

      def test_initial_activity_is_set
        activity = @plugin.instance_variable_get(:@latest_activity)
        assert_equal(@initial_activity, activity['reddit_follow1'])
        assert_equal(@initial_activity, activity['reddit_follow2'])
      end

      def test_new_activity_is_sent_to_channel
        attributes = {
            id: 'ckjsd92',
            kind: 't1',
            name: 't1_ckjsd92',
            author: 'MO_Kaboom',
            body: 'This is the new comment body',
            link_title: 'This is the new thread title',
            link_url: 'http://www.reddit.com/r/gigantic/comments/2goxpc/a_request_to_anyone_going_to_pax_east/'
        }
        new_activity = ::Redd::Objects::Comment.new(nil, attributes)
        @plugin.stubs(:get_latest_activity).returns(new_activity)

        @plugin.expects(:send_message_to_channels).times(2)
        @plugin.reddit_update
      end

      def test_new_activity_is_set_to_latest
        attributes = {
            id: 'ckjsd92',
            kind: 't1',
            name: 't1_ckjsd92',
            author: 'MO_Kaboom',
            body: 'This is the new comment body',
            link_title: 'This is the new thread title',
            link_url: 'http://www.reddit.com/r/gigantic/comments/2goxpc/a_request_to_anyone_going_to_pax_east/'
        }
        new_activity = ::Redd::Objects::Comment.new(nil, attributes)
        @plugin.stubs(:get_latest_activity).returns(new_activity)

        @plugin.reddit_update

        activity = @plugin.instance_variable_get(:@latest_activity)
        assert_equal(new_activity, activity['reddit_follow1'])
        assert_equal(new_activity, activity['reddit_follow2'])

      end
    end
  end
end
