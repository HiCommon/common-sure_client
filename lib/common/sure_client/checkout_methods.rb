# frozen_string_literal: true

require 'common/sure_client/api_methods'

module Common
  module SureClient
    module CheckoutMethods
      include ApiMethods

      CHECKOUT_ENDPOINT = '/api/partner/v1.1/protections/renters/checkout'

      def checkout(
        property_address:,
        details:,
        settings:,
        plan_id:,
        quote_id:,
        email:,
        payment_cadence:
      )
        post(
          endpoint: CHECKOUT_ENDPOINT,
          body: {
            property_address: property_address,
            details: details,
            settings: settings,
            plan_id: plan_id,
            quote_id: quote_id,
            email: email,
            payment_cadence: payment_cadence
          }
        )
      end
    end
  end
end
