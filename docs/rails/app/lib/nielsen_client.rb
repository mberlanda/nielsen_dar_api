
# frozen_string_literal: true

class NielsenClient
  include NielsenDarApi::Helper

  def execute
    process_references
    process_exposures
  end

  def process_references
    process_available_campaigns_reference
    process_demographics_reference
    process_platforms_reference
    process_market_areas_reference
    process_campaigns_reference
    process_placements_reference
  end

  def process_exposures
    process_campaign_exposures
    process_placement_exposures
    process_placement_daily_data
  end

  private

  def process_available_campaigns_reference
    @available_campaigns = available_campaign_list
  end

  def process_demographics_reference
    @demographics = demographic_list
  end

  def process_platforms_reference
    @platforms = platform_list
  end

  def process_market_areas_reference
    @market_areas = market_area_list
  end

  def available_campaigns
    @available_campaigns ||= process_available_campaigns_reference
  end

  def available_campaigns_map
    # This could be the result of a query or anything else
    @available_campaigns_map ||= Hash[available_campaigns.map do |h|
      [h['campaignId'], parse_nielsen_date(h['reportDate'])]
    end]
  end

  def max_report_date
    available_campaigns_map.values.max
  end

  def process_campaigns_reference
    @campaigns ||= campaign_list(max_report_date)
  end

  def process_placements_reference(chunk_size = 10)
    @sites = [].tap do |s|
      available_campaigns_map.each_slice(chunk_size) do |chunk|
        s << site_list(chunk)
      end
    end.flatten
  end

  def process_campaign_exposures(chunk_size = 10)
    @campaign_exposures ||= [].tap do |campaign_data|
      available_campaigns_map.each_slice(chunk_size) do |chunk|
        campaign_data << campaign_exposure_list(chunk)
      end
    end.flatten
  end

  def process_placement_exposures(chunk_size = 10)
    @placement_exposures ||= [].tap do |placement_data|
      available_campaigns_map.each_slice(chunk_size) do |chunk|
        placement_data << placement_exposure_list(chunk)
      end
    end.flatten
  end

  def process_campaign_date_ranges
    start_dates = {}
    end_dates = {}
    process_campaigns_reference.each do |h|
      start_dates[h['campaignId']] = parse_nielsen_date(h['campaignStartDate'])
      end_dates[h['campaignId']] = parse_nielsen_date(h['campaignEndDate'])
    end
    [start_date, end_date]
  end

  def find_campaign_acquisition_range(original_id, report_date, start_dates, end_dates, max_dates)
    start_date = [start_dates.fetch(original_id), max_dates[original_id]].compact.max
    end_date = [end_dates.fetch(original_id), report_date].min
    (start_date..end_date).to_a
  end

  def process_placement_daily_data(_chunk_size = 10)
    @placement_daily_exposures ||= [].tap do |placement_daily_data|
      start_dates, end_dates = process_campaign_date_ranges
      max_dates = {} # keep in account any previous acquisition with maximum campaignDataDate acquired
      available_campaigns_map.each do |original_id, report_date|
        refresh_access_token
        range_dates = find_campaign_acquisition_range(original_id, report_date, start_dates, end_dates, max_dates)

        range_dates.each_slice(5) do |date_slice|
          list = placement_daily_datum_list(original_id, date_slice)
          placement_daily_data << list
        end
      end
    end.flatten
  end

  def parse_nielsen_date(date_string)
    Date.strptime(date_string, NielsenDarApi.configuration.date_format)
  end
end
