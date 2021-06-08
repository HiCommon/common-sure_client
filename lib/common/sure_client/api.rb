# frozen_string_literal: true

require 'common/sure_client/plans_methods'
require 'common/sure_client/rates_methods'
require 'common/sure_client/checkout_methods'
require 'common/sure_client/cadences_methods'
require 'common/sure_client/payment_method_methods'
require 'common/sure_client/purchase_methods'

module Common
  module SureClient
    class Api
      include PlansMethods
      include RatesMethods
      include CheckoutMethods
      include CadencesMethods
      include PaymentMethodMethods
      include PurchaseMethods
    end
  end
end
