# frozen_string_literal: true

require 'rest_client'

module NielsenDarApi
  module Helper
    module Authorization
      def auth_header(options = {})
        {
          'Authorization' => bearer_access_token,
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }.merge(options)
      end

      def bearer_access_token
        @bearer_access_token ||= 'Bearer ' + get_authorization.fetch('access_token')
      end

      def refresh_access_token
        @bearer_access_token = 'Bearer ' + get_authorization.fetch('access_token')
      end

      def get_authorization(counter = 1)
        NielsenDarApi.configuration.validate_credentials!
        auth_body = compose_authorization_body
        auth_headers = compose_authorization_headers
        post_request(
          NielsenDarApi.configuration.auth_url, auth_body, auth_headers
        )
      rescue RestClient::Unauthorized, RestClient::InternalServerError => e
        raise e unless counter < 4
        sleep(0.8 * counter)
        get_authorization(counter + 1)
      end

      private

      def compose_authorization_body
        {
          grant_type: NielsenDarApi.configuration.grant_type,
          username: NielsenDarApi.configuration.username,
          password: NielsenDarApi.configuration.password
        }
      end

      def compose_authorization_headers
        {
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Authorization' => NielsenDarApi.configuration.basic_token
        }
      end
    end
  end
end
