module NielsenDarApi
  class Configuration
    attr_accessor :auth_url, :base_url, :country_code, :date_format

    def initialize
      @auth_url = 'https://api.developer.nielsen.com/watch/oauth/token'
      @base_url = 'https://api.developer.nielsen.com/watch/dar'
      @country_code = 'IT'
      @date_format = '%m/%d/%Y'
    end
  end
end
