# frozen_string_literal: true

module NielsenDarApi
  module Helper
    module Exposure
      %i[campaign placement].each do |item|
        define_method("#{item}_exposure_list") do |campaign_api_map|
          cfg = NielsenDarApi::Endpoint.send("#{item}_exposure")
          url = compose_url(cfg.fetch(:url))
          result = []
          threads = []
          campaign_api_map.each do |original_id, report_date|
            threads << send("#{item}_exposure_thread", url, result, original_id, report_date)
          end
          threads.map(&:join)
          result.flatten
        end

        define_method("#{item}_exposure_thread") do |url, result, original_id, report_date|
          Thread.new do
            body = default_body.merge('date' => format_report_date(report_date),
                                      'campaignId' => original_id)
            begin
              result << post_request(url, body.to_json, auth_header)
            rescue RestClient::InternalServerError, RestClient::BadGateway, Net::ReadTimeout
              sleep(1.0)
              send("#{item}_exposure_thread", url, result, original_id, report_date)
            end
          end
        end
      end

      def placement_daily_datum_list(original_id, dates)
        url = compose_url(NielsenDarApi::Endpoint.placement_daily_datum.fetch(:url))
        result = []
        threads = []
        dates.each do |date|
          threads << placement_daily_datum_thread(url, result, original_id, date)
        end
        threads.map(&:join)
        result.flatten
      end

      def placement_daily_datum_thread(url, result, original_id, date)
        Thread.new do
          body = default_body.merge('startDate' => format_report_date(date),
                                    'endDate' => format_report_date(date),
                                    'campaignId' => original_id)
          begin
            result << post_request(url, body.to_json, auth_header)
          rescue RestClient::InternalServerError, RestClient::BadGateway, Net::ReadTimeout
            sleep(1.0)
            placement_daily_datum_thread(url, result, original_id, date)
          rescue RestClient::NotFound
            result << []
          end
        end
      end
    end
  end
end
