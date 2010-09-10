Factory.sequence :address do |n|
  "#{n} Dead End Street, Styx, ZZ 66666"
end

Factory.define :address do |address|
  address.address { Factory.next :address }
end
