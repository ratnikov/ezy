ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

FakeWeb.allow_net_connect = false

require 'template'

class ActiveSupport::TestCase
  include RR::Adapters::TestUnit

  def register_geo_location(query, latitude, longitude)
    template = Template.new(File.join(Rails.root, 'test', 'fixtures', 'google_geo_response.xml.erb'), :address => query, :latitude => latitude, :longitude => longitude)

    FakeWeb.register_uri :get, URI.escape("http://maps.google.com/maps/geo?key=#{ApplicationConfig.google_api_key}&output=xml&q=#{query}"), :body => template.to_s
  end
end
