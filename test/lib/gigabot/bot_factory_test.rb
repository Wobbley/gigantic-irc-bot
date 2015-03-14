
require File.dirname(__FILE__) + '/../../helper'
require File.dirname(__FILE__) + '/../../../lib/gigabot/bot_factory'
require File.dirname(__FILE__) + '/../../../lib/utils/configuration'

module Gigabot
  class BotFactoryTest < TestCase
    def setup
      Gigabot::Utils::Configuration.load(File.dirname(__FILE__) + '/../../fixtures/test_config.yml')
    end

    def test_create_bot_from_file
      bot = BotFactory.from_config(Gigabot::Utils::Configuration.config)

      assert_equal 'foo.example.com', bot.config.server
      assert_equal %w(#foo #bar), bot.config.channels
      assert_equal 'foobot', bot.config.nick
    end

    def test_raise_error_if_irc_configuration_is_missing
      exception = assert_raises RuntimeError do
        Gigabot::Utils::Configuration.config.clear

        BotFactory.from_config(Gigabot::Utils::Configuration.config)
      end
      assert_equal 'Config file required', exception.message
    end

    def test_raise_error_if_server_is_missing
      exception = assert_raises RuntimeError do
        Gigabot::Utils::Configuration.config.irc.server = nil

        BotFactory.from_config(Gigabot::Utils::Configuration.config)
      end
      assert_equal 'Server is required', exception.message
    end

    def test_raise_error_if_channels_is_missing
      exception = assert_raises RuntimeError do
        Gigabot::Utils::Configuration.config.irc.channels = nil

        BotFactory.from_config(Gigabot::Utils::Configuration.config)
      end
      assert_equal 'At least one channel is required', exception.message
    end

    def test_raise_error_if_nick_is_missing
      exception = assert_raises RuntimeError do
        Gigabot::Utils::Configuration.config.irc.nick = nil

        BotFactory.from_config(Gigabot::Utils::Configuration.config)
      end
      assert_equal 'Nick is required', exception.message
    end

    def test_plugins_are_loaded
      bot = BotFactory.from_config(Gigabot::Utils::Configuration.config)

      assert_equal(
          [
              Commands::Twitter,
              Commands::FAQ,
              Commands::Teamspeak,
              Commands::Help,
              Commands::Bug,
              Commands::Reddit,
              Commands::Rules,
              Commands::Streams,
              Cinch::Plugins::LastSeen,
              Cinch::Memo
          ],
          bot.config.plugins.plugins
      )
    end

    def test_twitter_is_correctly_configured
      bot = BotFactory.from_config(Gigabot::Utils::Configuration.config)
      assert_equal(
          {
              consumer_key: 'test_key',
              consumer_secret: 'test_key_secret',
              access_token: 'test_access_token',
              access_token_secret: 'test_access_token_secret',
              follow: %w(twitter_follow1 twitter_follow2)
          }, bot.config.plugins.options[Commands::Twitter]
      )
    end

    def test_reddit_is_correctly_configured
      bot = BotFactory.from_config(Gigabot::Utils::Configuration.config)
      assert_equal(
          {
              client_id: 'test_id',
              client_secret: 'test_secret',
              user_agent: 'test_agent',
              following: %w(reddit_follow1 reddit_follow2)
          }, bot.config.plugins.options[Commands::Reddit])
    end
  end
end

