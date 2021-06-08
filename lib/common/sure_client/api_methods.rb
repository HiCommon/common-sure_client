# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

module Common
  module SureClient
    module ApiMethods
      def client
        @_client ||= Faraday.new(configuration.api_host) do |client|
          client.request :json
          client.headers['Authorization'] = "Token #{configuration.public_key}"
          client.response :json, content_type: /\bjson$/, parser_options: {symbolize_names: true}
          client.use Faraday::Response::RaiseError
          client.adapter Faraday.default_adapter
        end
      end

      def post(endpoint:, body: {})
        client.post(endpoint) do |req|
          req.body = body.to_json
        end
      end

      def configuration
        Common::SureClient.configuration
      end
    end
  end
end
