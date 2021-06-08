require 'spec_helper'

describe Common::SureClient::PlansMethods do
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

  subject { api.plans(property_address: params) }

  context 'when given valid parameters' do
    let(:params) do
      {
        street_address: '7400 River Road',
        city: 'North Bergen',
        region: 'NJ',
        postal: '07047',
        country_code: 'US'
      }
    end

    it 'returns the plans for the region', vcr: {match_requests_on: [:path]} do
      expect(subject.status).to eq 200
    end

    it 'contains the keys relevant to us', vcr: {match_requests_on: [:path]} do
      response_body = subject.body

      expect(response_body).to include :plans
      expect(response_body).to include :dynamic_form
      expect(response_body).to include :settings

      expect(response_body[:dynamic_form][:screens].count).to be >= 1
    end
  end

  context 'when given invalid parameters' do
    let(:params) do
      {
        street_address: '7400 River Road',
        city: 'North Bergen',
        region: 'NJ',
        country_code: 'US'
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
        expect(body[:error][:fields]).to include :property_address__postal
      end
    end
  end
end
