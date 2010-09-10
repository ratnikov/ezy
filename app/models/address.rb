require 'geocoder'

class Address < ActiveRecord::Base
  attr_accessible :address

  validate :lookup_coordinates

  private

  def lookup_coordinates
    location = Geocoder.locate(address)

    write_attribute :lat, location.latitude
    write_attribute :lng, location.longitude
  rescue Graticule::AddressError
    errors[:address] << "Failed to lookup address"
  end
end
