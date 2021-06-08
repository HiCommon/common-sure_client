# frozen_string_literal: true

require 'common/sure_client/api_methods'

module Common
  module SureClient
    module CadencesMethods
      include ApiMethods

      CADENCES_ENDPOINT = '/api/partner/v1.1/protections/renters/cadences'

      def cadences(property_address:, quote_id:)
        post(
          endpoint: CADENCES_ENDPOINT,
          body: {
            property_address: property_address,
            quote_id: quote_id
          }
        )
      end
    end
  end
end
