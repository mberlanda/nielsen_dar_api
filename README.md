# NielsenDarApi

[![Build Status](https://travis-ci.org/mberlanda/nielsen_dar_api.svg)](https://travis-ci.org/mberlanda/nielsen_dar_api)

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

Please refer to the [Rails Usage documentation](docs/rails.md)

## Standalone Usage

Please refer to the [Standalone Usage documentation](docs/standalone.md)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mberlanda/nielsen_dar_api.

