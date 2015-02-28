require 'rubygems'
require 'rake/testtask'

require File.dirname(__FILE__) + '/lib/utils/configuration'
require File.dirname(__FILE__) + '/lib/gigabot/bot_factory'

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
end

desc 'Run gigabot'
task :run do
  Gigabot::Utils::Configuration.load(File.dirname(__FILE__) + '/config.yml')

  bot = Gigabot::BotFactory.from_config(Gigabot::Utils::Configuration.config)

  p_read, p_write = IO.pipe

  Thread.start(bot, p_read) do |b, pr|
    pr.read
    pr.close
    b.quit 'Quiting but probably just updating myself brb'
    exit
  end

  %w(INT SIGTERM).each { |signal| trap(signal) { p_write.close } }

  bot.start
end
