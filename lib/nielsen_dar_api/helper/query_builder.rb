# frozen_string_literal: true

require 'date'
require 'rest_client'

module NielsenDarApi
  module Helper
    module QueryBuilder
      def post_request(url, body = {}, headers = {})
        res = RestClient.post(url, body, headers)
        return [] if res.code == 204
        JSON.parse(res.body)
      end

      def default_body(options = {})
        { 'countryCode' => NielsenDarApi.configuration.country_code }.merge(options)
      end

      def compose_url(*args)
        url = NielsenDarApi.configuration.base_url, *args
        url.map(&:to_s).join('/')
      end

      def format_report_date(date, date_format = NielsenDarApi.configuration.date_format)
        date.strftime(date_format)
      end
    end
  end
end
