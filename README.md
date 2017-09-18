# NielsenDarApi

The purpose of this gem is to make calls to Nielsen DAR reporting API.
It may be not include all possible endpoints.

## Installation

Add this line to your application's Gemfile:

```ruby
git 'https://github.com/mberlanda/nielsen_dar_api.git', branch: 'master' do
  gem 'nielsen_dar_api'
end
```

And then execute:

    $ bundle

## Rails Usage

Assuming that you are using it inside a Rails Application, you should create an initializer as follows:

```rb
# config/initializers/nielsen_dar_api.rb
NielsenDarApi.configure do |config|
  config.username = ENV['NIELSEN_DAR_USERNAME'] # or something like 'someone@example.com'
  config.password = ENV['NIELSEN_DAR_PASSWORD'] # or something like 'password'
  config.basic_token = ENV['NIELSEN_DAR_BASIC_TOKEN'] # or something like 'Basic c29tZW9uZUBleGFtcGxlLmNvbTpwYXNzd29yZA=='
end
```

## Standalone Usage

Please refer to the [Standalone Usage documentation](docs/standalone.md)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mberlanda/nielsen_dar_api.

