require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rubygems'
require 'minitest/autorun'
module Gigabot
  class TestCase < Minitest::Test
  end
end