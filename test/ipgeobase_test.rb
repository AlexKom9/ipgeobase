# frozen_string_literal: true

require "webmock/minitest"

require_relative "test_helper"

class IpgeobaseTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_return_meta_info
    stub_request(:get, "http://ip-api.com/xml/8.8.8.8")
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Host" => "ip-api.com",
          "User-Agent" => "Ruby"
        }
      )
      .to_return(status: 200, body: File.read("test/mocks/response.xml"), headers: {})

    ip_meta = Ipgeobase.lookup("8.8.8.8")

    assert_equal ip_meta.city, "Ashburn"
    assert_equal ip_meta.country, "United States"
    assert_equal ip_meta.country_code, "US"
    assert_equal ip_meta.lat, "39.03"
    assert_equal ip_meta.lon, "-77.5"
    assert_equal ip_meta.timezone, "America/New_York"
  end
end
