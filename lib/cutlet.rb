# frozen_string_literal: true

require 'cutlet/version'
require 'cutlet/response_mapper'

module Cutlet
  class Error < StandardError; end

  def self.serve(event:, context:, app:)
    env = {
      'lambda.context' => context,
      'lambda.event'   => event
    }

    app_response = app.call(env)

    ResponseMapper.new(*app_response).to_json
  end
end
