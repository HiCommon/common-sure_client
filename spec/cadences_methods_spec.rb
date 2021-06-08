require 'spec_helper'

describe Common::SureClient::CadencesMethods do
  before do
    Common::SureClient.configure do |config|
      config.public_key = ENV['SURE_PUBLIC_KEY']
      config.secret_key = ENV['SURE_SECRET_KEY']
      config.api_host = ENV['SURE_API_HOST']
    end
  end

  let(:api) do
    class TestApi
    end

    api = TestApi.new
    api.extend(described_class)
  end

  subject { api.cadences(**params) }

  context 'when given valid parameters' do
    let(:params) do
      {
        property_address: {
          street_address: '355 South End Avenue',
          unit: '',
          city: 'New York',
          region: 'NY',
          postal: '10280',
          country_code: 'US'
        },
        quote_id: 'QRASU9LKLRZ'
      }
    end

    it 'returns a recaculated quote', vcr: {match_requests_on: [:path]} do
      expect(subject.status).to eq 200
    end

    it 'contains the keys relevant to us', vcr: {match_requests_on: [:path]} do
      response_body = subject.body

      expect(response_body).to include :cadences
      expect(response_body).to include :total_premium
      expect(response_body[:cadences].count).to eq 2
    end
  end

  context 'when given invalid parameters' do
    let(:params) do
      {
        property_address: {
          street_address: '355 South End Avenue',
          unit: '',
          city: 'New York',
          region: 'NY',
          postal: '10280',
          country_code: 'US'
        },
        quote_id: ''
      }
    end

    it 'returns a 400 error', vcr: {match_requests_on: [:path]} do
      expect { subject }.to raise_error do |error|
        expect(error).to be_a Faraday::ClientError
        expect(error.response[:status]).to eq 400
      end
    end

    it 'returns an error message', vcr: {match_requests_on: [:path]} do
      expect { subject }.to raise_error do |error|
        body = JSON.parse(error.response[:body], symbolize_names: true)
        expect(body[:error][:code]).to eq 'invalid_input'
        expect(body[:error][:fields]).to include :quote_id
      end
    end
  end
end
