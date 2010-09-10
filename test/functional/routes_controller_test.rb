require 'test_helper'

class RoutesControllerTest < ActionController::TestCase
  context "#new" do
    setup { get :new }

    should render_template('new')

    should("assign to @route") { assert_not_nil assigns(:route) }
  end

  context "#create" do
    setup do
      register_geo_locations 'point A' => [ 1, 1 ], 'point B' => [ 2, 2 ]

      post :create, :route => { :from_address => 'point A', :to_address => 'point B', :arrive_at => @arrive_at = Time.now, :email => 'someone@example.com', :password => 'secret' }
    end

    should render_template('create')

    should("create a user") do
      assert_not_nil User.authenticate('someone@example.com', 'secret')
    end

    should("create a route") do
      assert_not_nil route = assigns(:route), "Should assign @route"

      assert Route.exists?(route), "Should save the route in db"

      assert_equal User.authenticate('someone@example.com', 'secret'), route.user, "Should assign the user correctly"
      
      assert_equal Address.find_by_address('point A'), route.from
      assert_equal Address.find_by_address('point B'), route.to

      assert_equal @arrive_at, route.arrive_at
    end
  end
end
