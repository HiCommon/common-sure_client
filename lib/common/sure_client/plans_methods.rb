# frozen_string_literal: true

require 'common/sure_client/api_methods'

module Common
  module SureClient
    module PlansMethods
      include ApiMethods

      PLANS_ENDPOINT = '/api/partner/v1.1/protections/renters/plans'

      def plans(property_address:)
        post(
          endpoint: PLANS_ENDPOINT,
          body: {
            property_address: property_address
          }
        )
      end
    end
  end
end
