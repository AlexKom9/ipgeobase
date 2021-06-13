# frozen_string_literal: true

require_relative "ipgeobase/version"
require "net/http"
require "uri"
require "nokogiri-happymapper"

module Ipgeobase
  class Error < StandardError; end

  class << self
    def lookup(ip)
      HappyMapper.parse(Net::HTTP.get(URI("http://ip-api.com/xml/#{ip}")))
    end
  end
end
