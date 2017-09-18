# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NielsenDarApi::Helper::QueryBuilder do
  let(:query_builder) { Class.new.extend(NielsenDarApi::Helper::QueryBuilder) }

  context 'should compose_url' do
    it 'works with default base_url' do
      expect(query_builder.compose_url('foo', 'bar')).to eq(
        'https://api.developer.nielsen.com/watch/dar/foo/bar'
      )
    end
    it 'works with custom base_url' do
      NielsenDarApi.configure do |c|
        c.base_url = 'http://www.example.com'
      end
      expect(query_builder.compose_url('foo', 'bar')).to eq(
        'http://www.example.com/foo/bar'
      )
    end
  end

  context 'should default_body' do
    it 'works with default country_code' do
      expect(query_builder.default_body).to eq('countryCode' => 'IT')
    end
    it 'works with custom country_code' do
      NielsenDarApi.configure do |c|
        c.country_code = 'UK'
      end
      expect(query_builder.default_body).to eq('countryCode' => 'UK')
    end
    it 'works with countryCode as parameter' do
      expect(query_builder.default_body('countryCode' => 'US')).to eq('countryCode' => 'US')
    end
  end

  context 'should format_report_date' do
    let(:date) { Date.new(2017, 10, 1) }

    it 'works with default date_format' do
      expect(query_builder.format_report_date(date)).to eq('10/01/2017')
    end
    it 'works with custom date_format' do
      NielsenDarApi.configure do |c|
        c.date_format = '%Y-%m-%d'
      end
      expect(query_builder.format_report_date(date)).to eq('2017-10-01')
    end
    it 'works with date_format as parameter' do
      expect(query_builder.format_report_date(date, '%Y-%m-%d')).to eq('2017-10-01')
    end
  end
end
