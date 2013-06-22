require 'stringio'

Given(/^I can control the rovers$/) do
  @output = ''
  stdout_mock = StringIO.new(@output)
  @control = Rover::Control.new(stdout_mock)
end

When(/^I send the instructions:$/) do |instructions|
  @control.execute(instructions)
end

Then(/^the output should be:$/) do |string|
  expect(@output).to equal(string)
end