require 'spec_helper'

describe Common::SureClient::CheckoutMethods do
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

  subject { api.checkout(**params) }

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
        plan_id: '5a64bf5a0eccd83bb79fbaf5',
        quote_id: 'QRASU9LKLRZ',
        email: 'art@ucnle.com',
        settings: {
          policy_effective_date: '2019-08-23',
          personal_property_coverage: 10000,
          all_peril_deductible: 500,
          hurricane_deductible: nil,
          liability_limit: 100000,
          medical_limit: nil,
          include_pet_damage: false,
          include_water_backup: false,
          include_identity_fraud: false,
          include_replacement_cost: true
        },
        payment_cadence: nil,
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
        }
      }
    end

    it 'returns a recaculated quote', vcr: {match_requests_on: [:path]} do
      expect(subject.status).to eq 200
    end

    it 'contains the keys relevant to us', vcr: {match_requests_on: [:path]} do
      response_body = subject.body

      expect(response_body).to include :items
      expect(response_body).to include :grandtotal
      expect(response_body).to include :currency
      expect(response_body).to include :quote
      expect(response_body[:quote]).to include :id
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
          country_code: 'US'
        },
        plan_id: '5a64bf5a0eccd83bb79fbaf5',
        quote_id: 'QRASU9LKLRZ',
        email: 'art@ucnle.com',
        settings: {
          policy_effective_date: '2019-08-23',
          personal_property_coverage: 10000,
          all_peril_deductible: 500,
          hurricane_deductible: nil,
          liability_limit: 100000,
          medical_limit: nil,
          include_pet_damage: false,
          include_water_backup: false,
          include_identity_fraud: false,
          include_replacement_cost: true
        },
        payment_cadence: nil,
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
        }
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
