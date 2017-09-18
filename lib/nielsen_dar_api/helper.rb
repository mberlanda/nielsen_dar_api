# frozen_string_literal: true

require 'nielsen_dar_api/helper/query_builder'
require 'nielsen_dar_api/helper/authorization'

module NielsenDarApi
  module Helper
    include NielsenDarApi::Helper::QueryBuilder
    include NielsenDarApi::Helper::Authorization
  end
end
