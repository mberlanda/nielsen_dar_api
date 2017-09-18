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

end
