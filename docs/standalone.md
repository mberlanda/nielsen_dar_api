# NielsenDarApi Standalone Usage

This gem can be used inside any ruby project - even outside frameworks.

## Installation

Add this line to your application's Gemfile:

```ruby
git 'https://github.com/mberlanda/nielsen_dar_api.git', branch: 'master' do
  gem 'nielsen_dar_api'
end
```

## Usage

You can refer to [this example](standalone/example.rb) for a working sample.

### 1. Gem Configuration

In order to work, this gem requires your credentials to be set in the configuration:
```ruby
require 'nielsen_dar_api'

NielsenDarApi.configure do |config|
  config.username = ENV['NIELSEN_DAR_USERNAME'] # 'email'
  config.password = ENV['NIELSEN_DAR_PASSWORD'] # 'password'
  config.basic_token = ENV['NIELSEN_DAR_AUTH_TOKEN'] # 'Basic auth token provided by Nielsen'
end
```
I would suggest to set this values as environment variables, but you can hard-code them if you prefer.

You can even change some default settings such as `config.country_code= 'IT'`

### 2. Instantiate a Client

At the current stage, there is not yet a proper Client class.
You can create one very easily:

```ruby
class SampleClient
  include NielsenDarApi::Helper
end
client = SampleClient.new
```

### 3. The API flow

When I work on Nielsen DAR Reporting API I tend to follow this flow for every import routine:

- process references: collect all details for every entity
- process exposures: collect exposure overall campaign and placement data + placement daily data

### 4. Process References

In this first step the gem handles

- process_available_campaigns : check which campaigns are available for my account
- process_demographics : get details about available demographic groups (e.g. All, Female, Female 12-17 ...)
- process_platforms : get details about available platforms (e.g. Computer, Mobile, Total-Digital ...)
- process_market_areas : get details about available market areas (this feature seems to be available only for US `countryCode`)
- process_campaigns : get details about campaigns
- process_placements : get details about the sites where the available campaigns are tracked

### 5. Process Exposures

In this first step the gem handles:

- process_campaign_exposures : gets overall campaign exposure data (either it is finished or not)
- process_placement_exposures : gets overall placement exposure data (either the campaign is finished or not)
- process_placement_daily_data : gets daily placement exposure data
