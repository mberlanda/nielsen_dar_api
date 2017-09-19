# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NielsenDarApi::Helper::Exposure do
  class MockedClient
    include NielsenDarApi::Helper
  end

  let(:exposer) { MockedClient.new }
  let(:campaign_exposure_keys) do
    %w[
      campaignDataDate campaignId platformId countryCode demoGroupId demoId
      siteId reach impressions universeEstimate viewableRateAverage
      measuredRateAverage viewableImpressions viewableImpressionsPercentage
      outOfViewImpressions outOfViewImpressionsPercentage undeterminedImpressions
      undeterminedImpressionsPercentage suspiciousImpressions suspiciousImpressionsPercentage
      viewableReach
    ]
  end
  # Excluding viewableRateAverage measuredRateAverage outOfViewImpressions outOfViewImpressionsPercentage
  let(:placement_exposure_keys) do
    %w[
      campaignDataDate campaignId platformId countryCode demoGroupId demoId
      siteId reach impressions universeEstimate viewableImpressions
      viewableImpressionsPercentage undeterminedImpressions undeterminedImpressionsPercentage
      suspiciousImpressions suspiciousImpressionsPercentage viewableReach
    ]
  end
  # Excluding reach viewableReach
  let(:placement_datum_exposure_keys) do
    %w[
      campaignDataDate campaignId platformId countryCode demoGroupId demoId
      siteId impressions universeEstimate viewableImpressions
      viewableImpressionsPercentage undeterminedImpressions undeterminedImpressionsPercentage
      suspiciousImpressions suspiciousImpressionsPercentage
    ]
  end

  subject { exposer }
  it { should respond_to(:campaign_exposure_list) }
  it { should respond_to(:campaign_exposure_thread) }
  it { should respond_to(:placement_exposure_list) }
  it { should respond_to(:placement_exposure_thread) }
  it { should respond_to(:placement_daily_datum_list) }
  it { should respond_to(:placement_daily_datum_thread) }

  context '#campaign_exposure_list' do
    it 'should receive an array of items' do
      allow(MockedClient).to receive('campaign_exposure_list').and_return(
        Support::Fixture.campaign_exposure_response
      )
      expect(MockedClient.campaign_exposure_list).to be_a(Array)
    end
    it 'should return items with expected keys' do
      allow(MockedClient).to receive('campaign_exposure_list').and_return(
        Support::Fixture.campaign_exposure_response
      )
      actual = MockedClient.campaign_exposure_list
      actual_keys = actual.first.keys
      expect(actual_keys).to include(*campaign_exposure_keys)
    end
  end

  context '#placement_exposure_list' do
    it 'should receive an array of items' do
      allow(MockedClient).to receive('placement_exposure_list').and_return(
        Support::Fixture.placement_exposure_response
      )
      expect(MockedClient.placement_exposure_list).to be_a(Array)
    end
    it 'should return items with expected keys' do
      allow(MockedClient).to receive('placement_exposure_list').and_return(
        Support::Fixture.placement_exposure_response
      )
      actual = MockedClient.placement_exposure_list
      actual_keys = actual.first.keys
      expect(actual_keys).to include(*placement_exposure_keys)
    end
  end

  context '#placement_daily_datum_list' do
    it 'should receive an array of items' do
      allow(MockedClient).to receive('placement_daily_datum_list').and_return(
        Support::Fixture.placement_daily_datum_response
      )
      expect(MockedClient.placement_daily_datum_list).to be_a(Array)
    end
    it 'should return items with expected keys' do
      allow(MockedClient).to receive('placement_daily_datum_list').and_return(
        Support::Fixture.placement_daily_datum_response
      )
      actual = MockedClient.placement_daily_datum_list
      actual_keys = actual.first.keys
      expect(actual_keys).to include(*placement_datum_exposure_keys)
    end
  end
end
