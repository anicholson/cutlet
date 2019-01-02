# frozen_string_literal: true

require 'cutlet/version'

module Cutlet
  class Error < StandardError; end

  def self.serve(event:, context:, app:)
    env = {
      'lambda.context' => context,
      'lambda.event'   => event
    }

    app_response = app.call(env)

    app_response
  end
end
