module NielsenDarApi
  class Configuration
    attr_accessor :auth_url, :base_url, :country_code, :date_format,
                  :username, :password, :basic_token, :grant_type

    def initialize
      @auth_url = 'https://api.developer.nielsen.com/watch/oauth/token'
      @base_url = 'https://api.developer.nielsen.com/watch/dar'
      @country_code = 'IT'
      @date_format = '%m/%d/%Y'
      @username = nil
      @password = nil
      @basic_token = nil
      @grant_type = 'password'
    end

    def validate_credentials!
      [:username, :password, :basic_token, :grant_type].each do |m|
        send(m) || required_field(m)
      end
      true
    end

    def required_field(name)
      raise NoMethodError, "Please define #{name} in NielsenDarApi configuration"
    end
  end
end
