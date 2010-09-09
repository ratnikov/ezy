require 'test_helper'

class RoutesControllerTest < ActionController::TestCase
  context "#new" do
    setup { get :new }

    should render_template('new')

    should assign_to(:route)
  end

  context "#create" do
    setup { post :create, :route => { :from => 'point A', :to => 'point B', :arrive_at => @arrive_at = Time.now, :email => 'someone@example.com', :password => 'secret' } }

    should redirect_to('route_path(Route.last)')

    should("create a user") do
      assert_not_nil User.authenticate('someone@example.com', 'secret')
    end

    should("create a route") do
      assert_not_nil route = assigns(:route), "Should assign @route"

      assert Route.exists?(route), "Should save the route in db"

      assert_equal User.authenticate('someone@example.com', 'secret'), route, "Should assign the user correctly"
      
      assert_equal 'point A', route.from
      assert_equal 'point B', route.to
      assert_equal @arrive_at, route.arrive_at
    end
  end
end
