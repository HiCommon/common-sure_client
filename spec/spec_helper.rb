# frozen_string_literal: true

require 'bundler/setup'
require 'pry-byebug'

require 'common/sure_client'

require 'vcr'
require 'webmock/rspec'

ENV['SURE_PUBLIC_KEY'] = 'foobar'
ENV['SURE_SECRET_KEY'] = 'foobar'
ENV['SURE_API_HOST'] = 'https://sure.app'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = {record: :once}
  c.configure_rspec_metadata!
end
