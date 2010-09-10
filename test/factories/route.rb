Factory.define :route do |route|
  route.arrive_at { 5.hours.from_now }

  route.to_address { 'default-to' }
  route.from_address { 'default-from' }

  route.email { Factory.next :email }
  route.password { "secret" }
end
