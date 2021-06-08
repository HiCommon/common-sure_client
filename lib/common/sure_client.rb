# frozen_string_literal: true

require 'common/sure_client/configuration'
require 'common/sure_client/api'

module Common
  module SureClient
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= SureClient::Configuration.new
      yield(configuration)
    end

    def self.reset
      self.configuration = SureClient::Configuration.new
    end
  end
end
