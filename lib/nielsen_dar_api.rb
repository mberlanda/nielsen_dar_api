# frozen_string_literal: true

require 'nielsen_dar_api/version'
require 'nielsen_dar_api/configuration'
require 'nielsen_dar_api/endpoint'
require 'nielsen_dar_api/helper'

module NielsenDarApi
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
