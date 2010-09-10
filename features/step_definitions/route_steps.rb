module RouteHelper
  def lookup_route(to, from)
    assert_not_nil route = Route.first(:conditions => { :to_id => lookup_address(to), :from_id => lookup_address(from) })

    route
  end

  def lookup_address(address)
    assert_not_nil address = Address.find_by_address(address), "Expected address #{address.inspect} to exist"

    address
  end
end

World(RouteHelper)
