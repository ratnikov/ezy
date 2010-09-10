require 'geocoder'

class Address < ActiveRecord::Base
  attr_accessible :address

  validates_presence_of :address

  after_validation :lookup_coordinates, :on => :create

  private

  def lookup_coordinates
    return if address.blank?

    location = Geocoder.locate(address)

    write_attribute :lat, location.latitude
    write_attribute :lng, location.longitude
  rescue Graticule::AddressError
    errors[:address] << "Failed to lookup address"
  end
end
