# Cutlet

In November 2018, Amazon Web Services announced their serverless platform, Lambda, [would support Ruby as a runtime][announcement].

Ruby has a long tradition of being useful for microservices, with a bunch of excellent Web frameworks built on top of the [Rack servlet specification][rack]. Wouldn't it be great if developers could drop their existing Rack apps into a Lambda environment with minimal fuss and next-to-no config?

Enter Cutlet!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cutlet'
```

And then execute:

    $ bundle

## Usage

For general documentation about AWS Lambda with Ruby, [check out their documentation][ruby_docs].

### Standalone Rack application

In your `handler.rb` (or whatever you've named it), require your application and serve it with Cutlet:

```ruby
# handler.rb

require 'cutlet'
require_relative './my_rack_app'

def handler(event:, context:)
  Cutlet.serve(event: event, context: context, app: MyRackApp)
end
```

That's it!

### Custom Rack with `config.ru` (WIP)

```ruby

require 'cutlet'

def handler(event:, context:)
  Cutlet.serve(event: event, context: context, rackup: 'config.ru')
end

```

or do it inline!

```ruby

require 'cutlet'
require 'rack-attack'

require_relative './my_rack_app'

def handler(event:, context:)
  Cutlet.serve(event: event, context: context) do
	use Rack::Attack
	
	run MyRackApp
  end
end

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/anicholson/cutlet][cutlet]. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Cutlet project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/anicholson/cutlet/blob/master/CODE_OF_CONDUCT.md).

[announcement]: https://aws.amazon.com/blogs/compute/announcing-ruby-support-for-aws-lambda/
[rack]: https://rack.github.io/
[cutlet]: https://github.com/anicholson/cutlet
[ruby_docs]: https://docs.aws.amazon.com/lambda/latest/dg/lambda-ruby.html
