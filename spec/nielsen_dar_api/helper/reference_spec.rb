# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NielsenDarApi::Helper::Reference do
  class MockedClient
    include NielsenDarApi::Helper
  end

  let(:referencer) { MockedClient.new }

  subject { referencer }
  it { should respond_to(:available_campaign_list) }
  it { should respond_to(:campaign_list) }
  it { should respond_to(:demographic_list) }
  it { should respond_to(:market_area_list) }
  it { should respond_to(:platform_list) }
  it { should respond_to(:site_list) }

  context '#available_campaign_list' do
    it 'should receive an array of items' do
      allow(MockedClient).to receive('available_campaign_list').and_return(
        Support::Fixture.available_campaign_reference_response
      )
      expect(MockedClient.available_campaign_list).to be_a(Array)
    end
    it 'should return items with expected keys' do
      allow(MockedClient).to receive('available_campaign_list').and_return(
        Support::Fixture.available_campaign_reference_response
      )
      expected_keys = %w[
        campaignId parentCampaignId reportDate startDate
        reportStatus campaignStatus releaseStatus dataReleaseId
      ]
      actual = MockedClient.available_campaign_list
      actual_keys = actual.first.keys
      expect(actual_keys).to include(*expected_keys)
    end
  end

  context '#demographic_list' do
    it 'should receive an array of items' do
      allow(MockedClient).to receive('demographic_list').and_return(
        Support::Fixture.demographic_reference_response
      )
      expect(MockedClient.demographic_list).to be_a(Array)
    end
    it 'should return items with expected keys' do
      allow(MockedClient).to receive('demographic_list').and_return(
        Support::Fixture.demographic_reference_response
      )
      expected_keys = %w[
        demoId demoGroupGender demoGroupAlphaCode demoGroupStartAge demoGroupEndAge
      ]
      actual = MockedClient.demographic_list
      actual_keys = actual.first.keys
      expect(actual_keys).to include(*expected_keys)
    end
  end

  context '#platform_list' do
    it 'should receive an array of items' do
      allow(MockedClient).to receive('platform_list').and_return(
        Support::Fixture.platform_reference_response
      )
      expect(MockedClient.platform_list).to be_a(Array)
    end
    it 'should return items with expected keys' do
      allow(MockedClient).to receive('platform_list').and_return(
        Support::Fixture.platform_reference_response
      )
      expected_keys = %w[
        platformCode platformDescription
      ]
      actual = MockedClient.platform_list
      actual_keys = actual.first.keys
      expect(actual_keys).to include(*expected_keys)
    end
  end

  context '#market_area_list' do
    it 'should receive an array of items' do
      allow(MockedClient).to receive('market_area_list').and_return(
        Support::Fixture.market_area_reference_response
      )
      expect(MockedClient.market_area_list).to be_a(Array)
    end
    it 'should return items with expected keys' do
      allow(MockedClient).to receive('market_area_list').and_return(
        Support::Fixture.market_area_reference_response
      )
      expected_keys = %w[
        countryCode countryName dmaCode dmaName
      ]
      actual = MockedClient.market_area_list
      actual_keys = actual.first.keys
      expect(actual_keys).to include(*expected_keys)
    end
  end

  context '#campaign_list' do
    it 'should receive an array of items' do
      allow(MockedClient).to receive('campaign_list').and_return(
        Support::Fixture.campaign_reference_response
      )
      expect(MockedClient.campaign_list(Date.new)).to be_a(Array)
    end
    it 'should return items with expected keys' do
      allow(MockedClient).to receive('campaign_list').and_return(
        Support::Fixture.campaign_reference_response
      )
      expected_keys = %w[
        campaignId parentCampaignId campaignName advertiserId
        advertiserName brandId brandName campaignStartDate campaignEndDate
        mediaType targetDemo targetStartAge targetEndAge adReferenceCampaignId
        countryCode viewabilityEnabled viewabilityProviderName
      ]
      actual = MockedClient.campaign_list(Date.new)
      actual_keys = actual.first.keys
      expect(actual_keys).to include(*expected_keys)
    end
  end

  context '#site_list' do
    it 'should receive an array of items' do
      allow(MockedClient).to receive('site_list').and_return(
        Support::Fixture.site_reference_response
      )
      expect(MockedClient.site_list([])).to be_a(Array)
    end
    it 'should return items with expected keys' do
      allow(MockedClient).to receive('site_list').and_return(
        Support::Fixture.site_reference_response
      )
      expected_keys = %w[
        campaignId siteId siteName siteURL adNetworkFlag
        placementId placementName countryCode
      ]
      actual = MockedClient.site_list([])
      actual_keys = actual.first.keys
      expect(actual_keys).to include(*expected_keys)
    end
  end
end
