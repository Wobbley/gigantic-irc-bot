require 'rubygems'
require 'app_conf'

module Gigabot
  module Utils
    class Configuration
      #TODO: Apparently class variables are bad...read up on it
      @@config = nil

      def self.load(configuration_file)
        @@config = AppConf.new
        @@config.load(configuration_file)
      end

      #Can this be written as an accesor, are there such things as class accessors?
      def self.config
        @@config
      end
    end
  end
end
