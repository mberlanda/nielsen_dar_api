# frozen_string_literal: true

NielsenDarApi.configure do |config|
  # Mandatory configuration
  config.username = ENV['NIELSEN_DAR_USERNAME'] # 'email'
  config.password = ENV['NIELSEN_DAR_PASSWORD'] # 'password'
  config.basic_token = ENV['NIELSEN_DAR_AUTH_TOKEN'] # 'Basic auth token provided by Nielsen'

  # Optional configuration
  # config.country_code= 'IT'
end
