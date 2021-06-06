# frozen_string_literal: true

require "webmock/minitest"

require_relative "test_helper"

class IpgeobaseTest < Minitest::Test
  def setup
    @response_json = %(
      {
        "status": "success",
        "country": "Russia",
        "countryCode": "RU",
        "region": "SVE",
        "regionName": "Sverdlovsk Oblast",
        "city": "Yekaterinburg",
        "zip": "620000",
        "lat": 56.8333,
        "lon": 60.6,
        "timezone": "Asia/Yekaterinburg",
        "isp": "Ural Branch of OJSC MegaFon GPRS/UMTS Network",
        "org": "OJSC MegaFon GPRS/UMTS Network",
        "as": "AS31224 PJSC MegaFon",
        "query": "83.169.216.199"
      }
    )
  end

  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_return_meta_info
    stub_request(:get, "http://ip-api.com/json/8.8.8.8")
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Host" => "ip-api.com",
          "User-Agent" => "Ruby"
        }
      ).to_return(status: 200, body: @response_json, headers: {})

    ip_meta = Ipgeobase.lookup("8.8.8.8")

    assert_equal ip_meta.city, "Yekaterinburg"
    assert_equal ip_meta.country, "Russia"
    assert_equal ip_meta.country, "Russia"
    assert_equal ip_meta.lat, 56.8333
    assert_equal ip_meta.lon, 60.6
  end
end
