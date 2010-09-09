Factory.sequence :address do |n|
  "#{n} Dead End Street, Styx, ZZ 66666"
end

Factory.define :route do |route|
  route.from { Factory.next :address }
  route.to { Factory.next :address }

  route.arrive_at { 5.hours.from_now }

  route.email { Factory.next :email }
  route.password { "secret" }
end
