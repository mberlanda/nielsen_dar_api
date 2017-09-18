require "spec_helper"

RSpec.describe NielsenDarApi do
  it "has a version number" do
    expect(NielsenDarApi::VERSION).not_to be nil
  end

  context "has some default configuration" do
    before(:all) do
      NielsenDarApi.configure {}
    end
    subject { NielsenDarApi.configuration }

    it { should respond_to(:auth_url) }
    it { should respond_to(:base_url) }
    it { should respond_to(:country_code) }
    it { should respond_to(:date_format) }
    it { should respond_to(:username) }
    it { should respond_to(:password) }
    it { should respond_to(:basic_token) }
    it { should respond_to(:grant_type) }

    it "should fail validate_credentials!" do
      expect {
        NielsenDarApi.configuration.validate_credentials!
      }.to raise_error( NoMethodError, /Please define/)
    end
  end

  context "requires some configuration" do
    before do
      NielsenDarApi.configure do |config|
        config.username = 'someone@example.com'
        config.password = 'password'
        config.basic_token = 'Basic c29tZW9uZUBleGFtcGxlLmNvbTpwYXNzd29yZA=='
      end
    end
    it "should pass validate_credentials! with username, password and basic_token" do
      expect(NielsenDarApi.configuration.validate_credentials!).to be(true)
    end
  end
end
