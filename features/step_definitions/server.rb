# frozen_string_literal: true

require 'cucumber/rspec/doubles'

# rubocop:disable Style/GlobalVars
Given('a harness') do
  $harness = Harness.new
  @harness = $harness
end
# rubocop:enable Style/GlobalVars

Given('a Rack application') do
  app = simple_rack_app

  allow(app).to receive(:call).and_call_original

  @harness.app = app
end

Given('a Cutlet-enabled handler method') do
  handler = Kernel.method('cucumber_simple_handler')

  @harness.handler = handler
end

When('in an API setting') do
  @harness.event = http_event_object
  @harness.context = default_context_object
end

Then('the Rack application is run') do
  expect(@harness.app).to have_received(:call)
end

When('I call the handler') do
  @harness.response = @harness.handler.call(event: @harness.event, context: @harness.context)
end

Then('a response is generated') do
  expect(@harness.response).not_to be_nil
end

Then('the lambda context is provided to the app') do
end

Then('the lambda event is provided to the app') do
end
