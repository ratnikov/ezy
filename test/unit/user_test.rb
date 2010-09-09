require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "creating a user" do
    should("not require email confirmation") do
      mock( ClearanceMailer ).confirmation(anything).never

      User.new(:email => 'someone@example.com', :password => 'secret').save!

      assert_not_nil User.authenticate('someone@example.com', 'secret'), "Should be authenticate the newly created user without any email"
    end
  end
end
