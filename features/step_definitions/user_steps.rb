Then /^user "(.*)" should exist$/ do |user_info|
  lookup_user(user_info)
end

Then /^user "(.*)" should have a route from "(.*)" to "(.*)"$/ do |user, from, to|
  user = lookup_user(user)

  assert user.routes.include?(lookup_route(to, from)), "Expected user to have a route from #{from.inspect} to #{to.inspect}"
end

module UserHelper
  def lookup_user(info)
    email, password = info.split(/\//)

    assert_not_nil user = User.authenticate(email, password), "Expected user #{info.inspect} to exist"

    user
  end
end

World(UserHelper)
