# frozen_string_literal: true

require 'common/sure_client/api_methods'

module Common
  module SureClient
    module PaymentMethodMethods
      include ApiMethods

      PAYMENT_METHOD_ENDPOINT = '/api/partner/v1/methods'

      def create_payment_method(first_name:, last_name:, email:, stripe_token:)
        post(
          endpoint: PAYMENT_METHOD_ENDPOINT,
          body: {
            first_name: first_name,
            last_name: last_name,
            email: email,
            token: stripe_token
          }
        )
      end
    end
  end
end
