Given /^following locations are known:$/ do |locations_table|
  locations_table.hashes.each do |hash|
    register_geo_location hash['address'], [ hash['latitude'], hash['longitude'] ]
  end
end
