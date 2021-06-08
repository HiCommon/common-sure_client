require 'spec_helper'

describe Common::SureClient::Configuration do
  before(:each) do
    Common::SureClient.reset
  end

  context 'when the gem is not configured' do
    it 'defaults to nil' do
      expect(Common::SureClient.configuration.secret_key).to be_nil
      expect(Common::SureClient.configuration.public_key).to be_nil
      expect(Common::SureClient.configuration.api_host).to be_nil
    end
  end

  context 'when values are set via the configure block' do
    let(:secret_key) { 'hushhush' }
    let(:public_key) { 'nohushhush' }
    let(:api_host) { 'https://sure.app' }

    before do
      Common::SureClient.configure do |config|
        config.secret_key = secret_key
        config.public_key = public_key
        config.api_host = api_host
      end
    end

    it 'sets the right values on the config' do
      expect(Common::SureClient.configuration.secret_key).to eq secret_key
      expect(Common::SureClient.configuration.public_key).to eq public_key
      expect(Common::SureClient.configuration.api_host).to eq api_host
    end
  end
end
