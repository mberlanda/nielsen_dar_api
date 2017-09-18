# frozen_string_literal: true

module Support
  module TestConfiguration
    def restore_default_configuration
      NielsenDarApi.configuration = NielsenDarApi::Configuration.new
    end
  end
end
