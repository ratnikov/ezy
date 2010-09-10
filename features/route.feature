Feature: In order to be able to share rides, users sohuld be able to interact with them

Scenario: A new-comer should be able to create a route
  Given I am on the home page
    
   When I fill in "route_from_address" with "1 Infinite Loop, Cupertino CA"
    And I fill in "route_to_address" with "1600 Amphitheatre Parkway, Mountain View, CA"

    And I fill in "route_arrive_at" with "12pm"

    And I fill in "route_email" with "steve@example.com"
    And I fill in "route_password" with "secret"

    And I press "Create"

   Then I should see /route.*created/
    And user "steve@example.com/secret" should exist
    And user "steve@example.com/secret" should have a route from "1 Infinite Loop, Cupertino CA" to "1600 Amphitheatre Parkway, Mountain View, CA"
