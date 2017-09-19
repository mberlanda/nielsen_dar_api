# frozen_string_literal: true

require 'nielsen_dar_api'
require 'date'
require 'json'

NielsenDarApi.configure do |config|
  config.username = 'email'
  config.password = 'password'
  config.basic_token = 'Basic auth token provided by Nielsen'
end

class SampleClient
  include NielsenDarApi::Helper
end

client = SampleClient.new

# process_available_campaigns
available_campaigns = client.available_campaign_list

# process_demographics
demographics = client.demographic_list

# process_platforms
platforms = client.platform_list

# process_market_areas
market_areas = client.market_area_list

# at this point it would be usefult to store somewhere the result
unless 2 > 1
  File.open('available_campaigns.json', 'w') do |f|
    f.write(JSON.pretty_generate(available_campaigns))
  end
end

# There are a few manipulations to do on available_campaigns list
campaigns_map = Hash[available_campaigns.map do |h|
  [h['campaignId'], Date.strptime(h['reportDate'], NielsenDarApi.configuration.date_format)]
end]
report_date = campaigns_map.values.max

# process_campaigns
campaigns = client.campaign_list(report_date)

# process_placements
# you should process the campaign list in slices to prevent 429 Too Many Requests Error
chunk_size = 10
sites = []
campaigns_map.each_slice(chunk_size) do |chunk|
  sites << client.site_list(chunk)
end

# process_campaign_exposures
# retrieves all data for campaigns exposure
campaign_data = []
campaigns_map.each_slice(chunk_size) do |chunk|
  campaign_data << client.campaign_exposure_list(chunk)
end

# process_placement_exposures
placement_data = []
campaigns_map.each_slice(chunk_size) do |chunk|
  placement_data << client.placement_exposure_list(chunk)
end


# process_placement_daily_data
# This is pretty tricky
report_dates = Hash[available_campaigns.map do |h|
  [h['campaignId'], Date.strptime(h['reportDate'], NielsenDarApi.configuration.date_format)]
end]
start_dates = Hash[campaigns.map do |h|
  [h['campaignId'], Date.strptime(h['campaignStartDate'], NielsenDarApi.configuration.date_format)]
end]
end_dates = Hash[campaigns.map do |h|
  [h['campaignId'], Date.strptime(h['campaignEndDate'], NielsenDarApi.configuration.date_format)]
end]
max_dates = {} # if already collected and stored somewhere

placement_daily_data = []
report_dates.each do |original_id, report_date|
  client.refresh_access_token
  start_date = [start_dates.fetch(original_id), max_dates[original_id]].compact.max
  end_date = [end_dates.fetch(original_id), report_date].min
  range_dates = (start_date..end_date).to_a

  range_dates.each_slice(5) do |date_slice|
    list = client.placement_daily_datum_list(original_id, date_slice)
    placement_daily_data << list
  end
end
