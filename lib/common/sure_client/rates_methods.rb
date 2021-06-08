# frozen_string_literal: true

require 'common/sure_client/api_methods'

module Common
  module SureClient
    module RatesMethods
      include ApiMethods

      RATES_ENDPOINT = '/api/partner/v1.1/protections/renters/rates'

      def rates(property_address:, details:, settings:, plan_id:)
        post(
          endpoint: RATES_ENDPOINT,
          body: {
            property_address: property_address,
            details: details,
            settings: settings,
            plan_id: plan_id
          }
        )
      end
    end
  end
end
