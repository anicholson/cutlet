# frozen_string_literal: true

require 'pry'
require 'json'
require 'cutlet'

Harness = Struct.new(:app, :event, :context, :handler, :response, :context_passed, :event_passed)

ContextReporter = -> (context) { $harness.context_passed = context }
EventReporter = -> (event) { $harness.event_passed = event }

def simple_rack_app
  proc do |env|
    context = env['lambda.context'] || {}
    event  = env['lambda.event'] || ''

    event_name = context.function_name

    ContextReporter.(context)
    EventReporter.(event)

    [200, [], [{ event_name: context[:function_name] }.to_json]]
  end
end

# rubocop:disable Style/GlobalVars
def cucumber_simple_handler(event:, context:)
  Cutlet.serve(event: event, context: context, app: $harness.app)
end
# rubocop:enable Style/GlobalVars

Context = Struct.new(:function_name, :function_version, :invoked_function_arn, :memory_limit_in_mb, :aws_request_id, :log_group_name, :deadline_ms, :identity, :client_context, keyword_init: true)

def http_event_object(path = '/')
  JSON.parse(%(
  {
      "requestContext": {
                          "elb": {
                                   "targetGroupArn": "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/lambda-target/d6190d154bc908a5"
                                 }
                        },
     "httpMethod": "GET",
     "path": "#{path}",
     "queryStringParameters": {},
     "headers": {
                  "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
                 "accept-encoding": "gzip",
                 "accept-language": "en-US,en;q=0.5",
                 "connection": "keep-alive",
                 "cookie": "cookie",
                 "host": "lambda-846800462.elb.amazonaws.com",
                 "upgrade-insecure-requests": "1",
                 "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0) Gecko/20100101 Firefox/60.0",
                 "x-amzn-trace-id": "Root=1-5bdb40ca-556d8b0c50dc66f0511bf520",
                 "x-forwarded-for": "72.21.198.66",
                 "x-forwarded-port": "80",
                 "x-forwarded-proto": "http"
                },
     "body": "",
     "isBase64Encoded": false
    }
  ))
end

def default_context_object(function_name = 'normal')
  Context.new(
    function_name: function_name
  )
end
