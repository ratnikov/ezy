require 'test_helper'

class RouteTest < ActiveSupport::TestCase
  %w(to from arrive_at).each { |attr| should validate_presence_of(attr) }

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
end
