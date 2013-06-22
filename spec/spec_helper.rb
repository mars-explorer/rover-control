require 'bundler'

$LOAD_PATH.unshift 'lib'
$LOAD_PATH.unshift 'spec'

Bundler.require

require 'rspec'
require 'rspec/mocks'

module RoverControl ; end

Dir["support/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.mock_with :rspec
  config.order = "random"
end