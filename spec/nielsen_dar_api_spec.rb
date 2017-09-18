require "spec_helper"

RSpec.describe NielsenDarApi do
  it "has a version number" do
    expect(NielsenDarApi::VERSION).not_to be nil
  end

  context "should have some default configuration" do
    before(:all) do
      NielsenDarApi.configure {}
    end
    subject { NielsenDarApi.configuration }

    it { should respond_to(:auth_url) }
    it { should respond_to(:base_url) }
    it { should respond_to(:country_code) }
    it { should respond_to(:date_format) }
  end

end
