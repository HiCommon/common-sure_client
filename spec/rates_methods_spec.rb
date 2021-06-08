require 'spec_helper'

describe Common::SureClient::RatesMethods do
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

  subject { api.rates(**params) }

  context 'when given valid parameters' do
    let(:params) do
      {
        property_address: {
          street_address: '7400 River Road',
          city: 'North Bergen',
          region: 'NJ',
          postal: '07047',
          country_code: 'US'
        },
        details: {
          pni_first_name: 'Art',
          pni_last_name: 'Garfunkel',
          pni_phone_number: '212-889-7766',
          has_mailing_address: false,
          dwelling_type: 'A',
          mandatory_insurance_requirement: true,
          number_of_losses: '0',
          animal_injury: false,
          has_sni: false,
          has_intrested_party: false,
          property_special_city: 'New York'
        },
        settings: {
          policy_effective_date: '2019-08-23'
        },
        plan_id: '5977a84e49d11179e7557da3'
      }
    end

    it 'returns a successful request', vcr: {match_requests_on: [:path]} do
      expect(subject.status).to eq 200
    end

    it 'contains the relevant keys', vcr: {match_requests_on: [:path]} do
      response_body = subject.body

      expect(response_body).to include :rates
      expect(response_body).to include :quote_id
      expect(response_body[:rates]).to include :defaults
    end
  end

  context 'when given invalid parameters', vcr: {match_requests_on: [:method, :path, :body]} do
    let(:params) do
      {
        property_address: {
          street_address: '7400 River Road',
          city: 'North Bergen',
          region: 'NJ',
          country_code: 'US'
        },
        details: {
        },
        settings: {
        },
        plan_id: '5977a84e49d11179e7557da3'
      }
    end

    it 'returns a 400', vcr: {match_requests_on: [:path]} do
      expect { subject }.to raise_error do |error|
        expect(error).to be_a Faraday::ClientError
        expect(error.response[:status]).to eq 400
      end
    end

    it 'contains the relevant keys', vcr: {match_requests_on: [:path]} do
      expect { subject }.to raise_error do |error|
        body = JSON.parse(error.response[:body], symbolize_names: true)
        expect(body[:error][:code]).to include 'invalid_input'
      end
    end
  end
end
