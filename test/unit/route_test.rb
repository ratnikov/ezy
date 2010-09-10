require 'test_helper'

class RouteTest < ActiveSupport::TestCase
  %w(to_address from_address arrive_at).each { |attr| should validate_presence_of(attr) }

  %w(email password).each { |user_attr| should validate_presence_of(user_attr) }

  context "creating a route" do
    should("create an associated user if none exists") do
      assert_nil User.find_by_email('someone@example.com')

      route = Factory.create(:route, :email => 'someone@example.com', :password => 'secret')

      assert_not_nil user = User.authenticate('someone@example.com', 'secret'), "Should create the user"

      assert_equal user, route.user#, "Should assign the route to the user"
    end

    should("assign to an existing user if email and password match") do
      user = User.create(:email => 'someone@example.com', :password => 'secret')

      assert_no_difference 'User.count' do
        route = Factory.create(:route, :email => 'someone@example.com', :password => 'secret')

        assert_equal user, route.user, "Should assign the existing user"
      end
    end

    should("report error if email is within system but password is not matched") do
      user = User.create(:email => 'someone@example.com', :password => 'secret')

      route = Factory.build(:route, :email => 'someone@example.com', :password => 'not-secret')

      assert_equal false, route.save, "Should fail to create the route"

      assert route.errors[:password].any? { |error| error =~ /incorrect/i }, "Should report that password is wrong"
    end
  end

  context "order_by_proximity scope" do
    should "return closest routes" do
      register_geo_locations 'chicago' => [ 41.85, -87.65 ],
        'new york' => [ 40.71, -74.00 ],
        'milwaukee' => [ 43.03, -87.90 ],
        'boston' => [ 42.35, -71.06 ],
        'san francisco' => [ 37.77, -122.41 ],
        'los angeles' => [ 34.05, -118.24 ]

      foo = Factory.create(:route, :from_address => 'milwaukee', :to_address => 'boston')
      bar = Factory.create(:route, :from_address => 'chicago', :to_address => 'new york')
      zeta = Factory.create(:route, :from_address => 'san francisco', :to_address => 'los angeles')

      assert_equal [ bar, foo, zeta ], Route.order_by_proximity(bar).all
    end
  end
end
