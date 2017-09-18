# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NielsenDarApi::Endpoint do
  subject { NielsenDarApi::Endpoint }

  it { should respond_to(:available_campaign_reference) }
  it { should respond_to(:campaign_reference) }
  it { should respond_to(:demographic_reference) }
  it { should respond_to(:market_area_reference) }
  it { should respond_to(:platform_reference) }
  it { should respond_to(:campaign_site_reference) }
  it { should respond_to(:campaign_exposure) }
  it { should respond_to(:placement_exposure) }
  it { should respond_to(:campaign_dma_exposure) }
  it { should respond_to(:placement_daily_datum) }

  context 'has default_endpoint private method' do
    it 'should raise an exception if no url is provided' do
      expect do
        NielsenDarApi::Endpoint.send(:default_endpoint, {})
      end.to raise_error(ArgumentError, /You should provide an url/)
    end
    it 'should raise an exception if url is not valid' do
      expect do
        NielsenDarApi::Endpoint.send(:default_endpoint, url: '')
      end.to raise_error(ArgumentError, /You should provide a valid url/)
    end
    it 'should work with valid arguments' do
      expect(
        NielsenDarApi::Endpoint.send(:default_endpoint,
                                     url: 'campaignratings/v2/CampaignDataAvailability')
      ).to eq(method: :get,
              url: 'campaignratings/v2/CampaignDataAvailability')
    end
  end

  context 'generates config for known endpoints' do
    it '#available_campaign_reference' do
      expect(NielsenDarApi::Endpoint.available_campaign_reference).to eq(method: :get,
                                                                         url: 'campaignratings/v2/CampaignDataAvailability')
    end
    it '#campaign_reference' do
      expect(NielsenDarApi::Endpoint.campaign_reference).to eq(method: :post,
                                                               url: 'campaignratings/v3/CampaignReference')
    end
    it '#demographic_reference' do
      expect(NielsenDarApi::Endpoint.demographic_reference).to eq(method: :get,
                                                                  url: 'campaignratings/v1/DemographicReference')
    end
    it '#market_area_reference' do
      expect(NielsenDarApi::Endpoint.market_area_reference).to eq(method: :get,
                                                                  url: 'campaignratings/v1/MarketReference')
    end
    it '#platform_reference' do
      expect(NielsenDarApi::Endpoint.platform_reference).to eq(method: :get,
                                                               url: 'campaignratings/v1/PlatformReference')
    end
    it '#campaign_site_reference' do
      expect(NielsenDarApi::Endpoint.campaign_site_reference).to eq(method: :get,
                                                                    url: 'campaignratings/v3/CampaignSiteReference')
    end
    it '#campaign_exposure' do
      expect(NielsenDarApi::Endpoint.campaign_exposure).to eq(method: :get,
                                                              url: 'campaignratings/v5/CampaignExposure')
    end
    it '#placement_exposure' do
      expect(NielsenDarApi::Endpoint.placement_exposure).to eq(method: :get,
                                                               url: 'campaignratings/v4/CampaignPlacementExposure')
    end
    it '#campaign_dma_exposure' do
      expect(NielsenDarApi::Endpoint.campaign_dma_exposure).to eq(method: :get,
                                                                  url: 'campaignratings/v3/CampaignDMAExposure')
    end
    it '#placement_daily_datum' do
      expect(NielsenDarApi::Endpoint.placement_daily_datum).to eq(method: :get,
                                                                  url: 'campaignratings/v3/CampaignPlacementExpCustomRange')
    end
  end
end
