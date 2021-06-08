require 'spec_helper'

describe Common::SureClient::PurchaseMethods do
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

  subject { api.purchase(**params) }

  context 'when given valid parameters' do
    let(:params) do
      {
        plan_id: 'foo',
        quote_id: 'bar',
        payment_method_id: 'baz',
        payment_cadence: 'qux'
      }
    end

    before do
      stub_request(:post, %r{/purchase}).and_return(status: 200, body: {agreement_id: 'agreement_id'}.to_json)
    end

    it 'returns a success response' do
      expect(subject.status).to eq 200
    end

    it 'returns a agreement_id' do
      response_body = subject.body
      expect(response_body['agreement_id']).to eq 'agreement_id'
    end
  end

  context 'when given invalid parameters' do
    let(:params) do
      {
        plan_id: 'foo',
        quote_id: 'bar',
        payment_method_id: 'baz',
        payment_cadence: 'qux'
      }
    end

    it 'returns a 400 status code', vcr: {match_requests_on: [:path, :method, :body]} do
      expect { subject }.to raise_error do |error|
        expect(error).to be_a(Faraday::ClientError)
        expect(error.response[:status]).to eq 400
      end
    end

    it 'returns an error message', vcr: {match_requests_on: [:path, :method, :body]} do
      expect { subject }.to raise_error do |error|
        body = JSON.parse(error.response[:body], symbolize_names: true)
        expect(body[:error][:code]).to eq 'invalid_input'
      end
    end
  end
end
