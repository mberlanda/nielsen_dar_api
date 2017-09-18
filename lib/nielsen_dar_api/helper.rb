# frozen_string_literal: true

require 'nielsen_dar_api/helper/query_builder'
require 'nielsen_dar_api/helper/authorization'
require 'nielsen_dar_api/helper/reference'

module NielsenDarApi
  module Helper
    include NielsenDarApi::Helper::QueryBuilder
    include NielsenDarApi::Helper::Authorization
    include NielsenDarApi::Helper::Reference
  end
end
