# frozen_string_literal: true

module Support
  class Fixture
    class << self
      %i[
        available_campaign demographic platform
        market_area campaign site
      ].each do |m|
        define_method("#{m}_response") do
          JSON.parse(File.read(file_path("#{m}_response.json")))
        end
      end

      def file_path(name)
        File.expand_path("../data/#{name}", __FILE__)
      end
    end
  end
end
