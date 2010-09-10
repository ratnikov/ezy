module Geocoder
  extend self

  def locate(address)
    service.locate address
  end

  private

  def service
    @service ||= Graticule.service(:google).new ApplicationConfig.google_api_key
  end
end 
