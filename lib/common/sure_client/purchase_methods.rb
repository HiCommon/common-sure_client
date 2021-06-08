# frozen_string_literal: true

require 'common/sure_client/api_methods'

module Common
  module SureClient
    module PurchaseMethods
      include ApiMethods

      PURCHASE_ENDPOINT = '/api/partner/v1.1/protections/renters/purchase'

      def purchase(plan_id:, quote_id:, payment_method_id:, payment_cadence:)
        post(
          endpoint: PURCHASE_ENDPOINT,
          body: {
            plan_id: plan_id,
            quote_id: quote_id,
            payment_method_id: payment_method_id,
            payment_cadence: payment_cadence
          },
        )
      end
    end
  end
end
