Factory.define :route do |route|
  route.arrive_at { 5.hours.from_now }

  route.to_address { Factory.next :address }
  route.from_address { Factory.next :address }

  route.email { Factory.next :email }
  route.password { "secret" }
end
