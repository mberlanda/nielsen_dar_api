# frozen_string_literal: true

module Support
  class Fixture
    class << self
      Dir.glob(File.expand_path('../data/*.json', __FILE__)).each do |file|
        method_name = File.basename(file, '.*')
        define_method(method_name) do
          JSON.parse(File.read(file))
        end
      end

      def file_path(name)
        File.expand_path("../data/#{name}", __FILE__)
      end
    end
  end
end
