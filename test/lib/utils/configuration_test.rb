require File.dirname(__FILE__) + '/../../helper'
require File.dirname(__FILE__) + '/../../../lib/utils/configuration'

module Gigabot
  module Utils
    class ConfigurationTest < TestCase
      def test_can_load_configuration_from_file
        Configuration.load(File.dirname(__FILE__) + '/../../fixtures/test_config.yml')

        #IRC Client
        assert_equal 'foo.example.com', Configuration.config.irc.server
        assert_equal %w(#foo #bar), Configuration.config.irc.channels
        assert_equal 'foobot', Configuration.config.irc.nick

        #Twitter Plugin
        assert_equal 'test_key', Configuration.config.twitter.consumer_key
        assert_equal 'test_key_secret', Configuration.config.twitter.consumer_secret
        assert_equal 'test_access_token', Configuration.config.twitter.access_token
        assert_equal 'test_access_token_secret', Configuration.config.twitter.access_token_secret
        assert_equal %w(follow1 follow2), Configuration.config.twitter.follow

        #Reddit plugin
        assert_equal 'test_id', Configuration.config.reddit.client_id
        assert_equal 'test_secret', Configuration.config.reddit.client_secret
        assert_equal 'test_agent', Configuration.config.reddit.user_agent
        assert_equal %w(test_follow1 test_follow2), Configuration.config.reddit.following
      end
    end
  end
end