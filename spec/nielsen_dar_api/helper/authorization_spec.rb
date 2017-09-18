# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NielsenDarApi::Helper::Authorization do
  let(:authorizer) { Class.new.extend(NielsenDarApi::Helper::Authorization) }

  it 'should not get_authorization with invalid configuration' do
    expect { authorizer.get_authorization }.to raise_error(NoMethodError, /Please define/)
  end

  context 'should get_authorization with valid configuration' do
    before do
      NielsenDarApi.configure do |config|
        config.username = 'someone@example.com'
        config.password = 'password'
        config.basic_token = 'Basic c29tZW9uZUBleGFtcGxlLmNvbTpwYXNzd29yZA=='
      end
    end

    it '#compose_authorization_body' do
      expect(authorizer.send(:compose_authorization_body)).to eq(
        grant_type: 'password',
        password: 'password',
        username: 'someone@example.com'
      )
    end
    it '#compose_authorization_headers' do
      expect(authorizer.send(:compose_authorization_headers)).to eq(
        'Authorization' => 'Basic c29tZW9uZUBleGFtcGxlLmNvbTpwYXNzd29yZA==',
        'Content-Type' => 'application/x-www-form-urlencoded'
      )
    end
  end

  context 'should generate base auth_header for api calls' do
    let(:sample_token) { 'mF_9.B5f-4.1JqM' }

    it '#bearer_access_token' do
      expect(authorizer).to receive(:get_authorization).and_return(
        'access_token' => sample_token
      )
      expect(authorizer.bearer_access_token).to eq('Bearer ' + sample_token)
    end

    it '#auth_header' do
      expect(authorizer).to receive(:get_authorization).and_return(
        'access_token' => sample_token
      )
      expect(authorizer.auth_header).to eq(
        'Authorization' => 'Bearer ' + sample_token,
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      )
    end

    it '#refresh_access_token' do
      refreshed_token = sample_token + 'abc'
      expect(authorizer).to receive(:get_authorization).and_return(
        'access_token' => refreshed_token
      )
      authorizer.refresh_access_token
      expect(authorizer.bearer_access_token).to eq('Bearer ' + refreshed_token)
    end
  end
end
