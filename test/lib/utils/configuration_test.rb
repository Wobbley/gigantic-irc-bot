require File.dirname(__FILE__) + '/../../helper'
require File.dirname(__FILE__) + '/../../../lib/utils/configuration'

module Gigabot
  module Utils
    class ConfigurationTest < TestCase
      def test_can_load_configuration_from_file
        Configuration.load(File.dirname(__FILE__) + '/../../fixtures/test_config.yml')

        assert_equal 'foo.example.com', Configuration.config.irc.server
        assert_equal %w(#foo #bar), Configuration.config.irc.channels
        assert_equal 'foobot', Configuration.config.irc.nick
        assert_equal 'test_key', Configuration.config.twitter.consumer_key
        assert_equal 'test_key_secret', Configuration.config.twitter.consumer_secret
        assert_equal 'test_access_token', Configuration.config.twitter.access_token
        assert_equal 'test_access_token_secret', Configuration.config.twitter.access_token_secret
        assert_equal %w(follow1 follow2), Configuration.config.twitter.follow
      end
    end
  end
end