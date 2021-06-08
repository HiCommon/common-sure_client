# frozen_string_literal: true

module Common
  module SureClient
    class Configuration
      attr_accessor :secret_key, :public_key, :api_host, :sure_stripe_publishable_key

      def initialize
        @secret_key = nil
        @public_key = nil
        @api_host = nil
        @sure_stripe_publishable_key = nil
      end
    end
  end
end
