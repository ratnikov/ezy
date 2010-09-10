require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  should validate_presence_of(:address)

  context "creating and address" do
    should ("lookup coordinates") do
      register_geo_location 'random place', [ 20, -20 ]

      assert (address = Address.new(:address => 'random place')).save

      assert_equal 20, address.lat
      assert_equal -20, address.lng
    end

    should("be invalid if couldn't lookup coordinates") do
      register_geo_location 'unknown place', :bad_address

      assert_equal false, (address = Address.new(:address => 'unknown place')).valid?, "Should not be valid"

      assert address.errors[:address].any? { |m| m =~ /invalid/i }, "Should have an error about unknown address"
    end
  end
end
