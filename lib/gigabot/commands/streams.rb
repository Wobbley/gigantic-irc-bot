require 'rubygems'
require 'cinch'
require 'cinch/commands'

require 'kappa'

module Gigabot
  module Commands
    class Streams
      include Cinch::Plugin
      include Cinch::Commands

      command :twitch, {},
              summary: 'Links all current live Gigantic streams',
              description: 'Links all current live Gigantic streams'
      command :twitch, { username: :string },
              summary: 'Links if online and streaming Gigantic',
              description: 'Links if online and streaming Gigantic'

      listen_to :channel

      def initialize(bot)
        super(bot)
        Twitch.configure { |config|  config.client_id = 'gigabot-v1' }
        @channels = bot.config.channels
        @streamers = config[:streamers]
        @currently_live = Hash.new
        initial_stream_status
      end

      timer 60, method: :twitch_update
      def twitch_update
        get_gigantic_streams.each do |stream|
          channel = stream.channel
          if not @currently_live.has_key?(channel.name) do
            message = "#{channel.display_name} just started streaming Gigantic, check the stream out here: #{stream.url}"
            send_message_to_channels(message)
          end
          elsif !channel.streaming? || stream.game_name != 'Gigantic'
            @currently_live.delete(channel.name)
          end
        end
      end

      def twitch(m, username=nil)
        if username.nil?
          streams = get_gigantic_streams
          return m.target.send('No streams currently online!') if streams.empty?

          m.target.send("[Online streams] #{format_url_and_viewers(streams).join('-')}")
        else
          stream = Twitch.streams.find(:game => 'Gigantic', username: username).first
          return m.target.send("User #{username} is offline or not streaming Gigantic") if stream.nil?

          m.target.send("#{stream.channel.display_name} is streaming Gigantic: #{stream.url}")
        end
      end

      def listen(m)
        stream_url = m.message.scan(/www.twitch\.tv\/([A-z_0-9]+)/)
        if stream_url.empty?
          return
        end
        user = Twitch.users.get(stream_url[0][0])
        channel = user.channel

        if user.streaming?
          m.target.send(Format(:bold, "<#{user.display_name}>") + " is streaming #{channel.game_name} '#{channel.status}'")
        else
          m.target.send(Format(:bold, "<#{user.display_name}>") + ' is not streaming')
        end
      end

      private
      def format_url_and_viewers(streams)
        url_and_views = []
        streams.each do |stream|
          url_and_views << "#{stream.url} (#{stream.viewer_count})"
        end
      end

      private
      def send_message_to_channels(message)
        @channels.each {|channel| Channel(channel).send(message)}
      end

      private
      def get_gigantic_streams
        Twitch.streams.find(:game => 'Gigantic', :channel => @streamers)
      end

      private
      def initial_stream_status
        get_gigantic_streams.each do |stream|
          @currently_live[stream.channel.name] = true
        end
      end

    end
  end
end

