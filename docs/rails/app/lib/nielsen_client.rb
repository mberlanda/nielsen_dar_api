
# frozen_string_literal: true

class NielsenClient
  include NielsenDarApi::Helper

  def execute
    process_references
  end

  def process_references
    process_available_campaigns
    process_demographics
    process_platforms
    process_market_areas
    process_campaigns
    process_placements
  end

  private

  def process_available_campaigns
    @available_campaigns = available_campaign_list
  end

  def process_demographics
    @demographics = demographic_list
  end

  def process_platforms
    @platforms = platform_list
  end

  def process_market_areas
    @market_areas = market_area_list
  end

  def campaigns_map
    # This could be the result of a query or anything else
    @campaigns_map ||= Hash[@available_campaigns.map do |h|
      [h['campaignId'], Date.strptime(h['reportDate'], NielsenDarApi.configuration.date_format)]
    end]
  end

  def process_campaigns
    report_date = @campaigns_map.values.max
    @campaigns = campaign_list(report_date)
  end

  def process_placements(chunk_size = 10)
    @sites = []
    @campaigns_map.each_slice(chunk_size) do |chunk|
      @sites << site_list(chunk)
    end
    @sites
  end
end
