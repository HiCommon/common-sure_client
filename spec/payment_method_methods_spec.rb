require 'spec_helper'

describe Common::SureClient::PaymentMethodMethods do
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

  subject { api.create_payment_method(**params) }

  context 'when given valid parameters' do
    let(:params) do
      {
        first_name: 'foo',
        last_name: 'bar',
        email: 'foobar@foobar.com',
        stripe_token: 'foobarstripe'
      }
    end

    it 'returns a success response', vcr: {match_requests_on: [:body, :method, :path]} do
      expect(subject.status).to eq 200
    end

    it 'returns a payment_method_id', vcr: {match_requests_on: [:body, :method, :path]} do
      response_body = subject.body
      expect(response_body[:payment_method_id]).to eq 'foobarstripe'
    end
  end
end
