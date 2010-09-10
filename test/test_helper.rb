ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

FakeWeb.allow_net_connect = false

require 'template'

class ActiveSupport::TestCase
  include RR::Adapters::TestUnit

  def fixture_file(file)
    File.join Rails.root, 'test', 'fixtures', file
  end

  def register_geo_location(query, options)
    body = case options
    when Array then Template.new(fixture_file('google_geo_response.xml.erb'), :address => query, :latitude => options.first, :longitude => options.last).to_s
    when :bad_address then fixture_file('google_geo_bad.xml')
    end

    FakeWeb.register_uri :get, URI.escape("http://maps.google.com/maps/geo?key=#{ApplicationConfig.google_api_key}&oe=utf8&output=xml&q=#{query}&sensor=false"), :body => body
  end

  def register_geo_locations(hash)
    hash.each { |(query, options)| register_geo_location query, options }
  end
end
