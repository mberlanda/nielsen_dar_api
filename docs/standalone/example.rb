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
