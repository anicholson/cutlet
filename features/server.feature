Feature: Rack app running in AWS Lambda

Background:
Given a harness
And a Rack application
And a Cutlet-enabled handler method
And in an API setting

Scenario: Running the application
When I call the handler
Then the Rack application is run
And a response is generated
And the lambda context was provided to the app
And the lambda event is provided to the app

Scenario: Passing a payload back to AWS lambda
When I call the handler
Then a response is generated
And the handler function returns a payload
