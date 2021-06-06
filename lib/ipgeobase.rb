# frozen_string_literal: true

require_relative "ipgeobase/version"
require 'net/http'
require 'uri'
require 'json'

module Ipgeobase
  class Error < StandardError; end

  class << self
    def lookup ip

      result = JSON.parse(Net::HTTP.get URI("http://ip-api.com/json/#{ip}")).transform_keys(&:to_sym)

      result.each do |key, value|
        result.define_singleton_method(key) do
          value
        end
      end
    end
  end
end