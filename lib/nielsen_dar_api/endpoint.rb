module NielsenDarApi
  module Endpoint
    extend self

    def available_campaign_reference
      @available_campaign_reference ||= default_endpoint({
        url: 'campaignratings/v2/CampaignDataAvailability'
      })
    end

    def campaign_reference
      @campaign_reference ||= default_endpoint({
        method: :post,
        url: 'campaignratings/v3/CampaignReference'
      })
    end

    def demographic_reference
      @demographic_reference ||= default_endpoint({
        url: 'campaignratings/v1/DemographicReference'
      })
    end

    def market_area_reference
      @market_area_reference ||= default_endpoint({
        url: 'campaignratings/v1/MarketReference'
      })
    end

    def platform_reference
      @platform_reference ||= default_endpoint({
        url: 'campaignratings/v1/PlatformReference'
      })
    end

    def campaign_site_reference
      @campaign_site_reference ||= default_endpoint({
        url: 'campaignratings/v3/CampaignSiteReference'
      })
    end

    def campaign_exposure
      @campaign_exposure ||= default_endpoint({
        url: 'campaignratings/v5/CampaignExposure'
      })
    end

    def placement_exposure
      @placement_exposure ||= default_endpoint({
        url: 'campaignratings/v4/CampaignPlacementExposure'
      })
    end

    def campaign_dma_exposure
      @campaign_dma_exposure ||= default_endpoint({
        url: 'campaignratings/v3/CampaignDMAExposure'
      })
    end

    def placement_daily_datum
      @placement_daily_datum ||= default_endpoint({
        url: 'campaignratings/v3/CampaignPlacementExpCustomRange'
      })
    end

    private

    def default_endpoint(options={})
      url = options[:url]
      raise ArgumentError, 'You should provide an url for the endpoint' unless url
      raise ArgumentError, 'You should provide a valid url for the endpoint' unless url.to_s.size > 0
      {
        method: :get,
        url: nil
      }.merge(options)
    end

  end
end
