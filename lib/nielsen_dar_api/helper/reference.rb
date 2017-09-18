# frozen_string_literal: true

module NielsenDarApi
  module Helper
    module Reference
      %i[
        available_campaign demographic market_area platform
      ].each do |metr|
        define_method("#{metr}_list") do
          cfg = NielsenDarApi::Endpoint.send("#{metr}_reference")
          post_request(compose_url(cfg.fetch(:url)), default_body.to_json, auth_header)
        end
      end

      def campaign_list(report_date)
        cfg = NielsenDarApi::Endpoint.campaign_reference
        body = default_body.merge('date' => format_report_date(report_date))
        post_request(compose_url(cfg.fetch(:url)), body, auth_header)
      end

      def site_list(campaign_api_map)
        cfg = NielsenDarApi::Endpoint.campaign_site_reference
        result = []
        threads = []
        campaign_api_map.each do |original_id, report_date|
          threads << site_request_thread(cfg, result, original_id, report_date)
        end
        threads.map(&:join)
        result.flatten
      end

      def site_request_thread(cfg, result, original_id, report_date)
        Thread.new do
          body = default_body.merge('date' => format_report_date(report_date),
                                    'campaignId' => original_id)
          begin
            result << post_request(compose_url(cfg.fetch(:url)), body.to_json, auth_header)
          rescue RestClient::InternalServerError, RestClient::BadGateway
            sleep(0.8)
            site_request_thread(cfg, result, original_id, report_date)
          end
        end
      end
    end
  end
end
