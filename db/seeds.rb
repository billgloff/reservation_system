# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Initializing default table inventory..."
Table.destroy_all
table_num = 1
(0..4).each do
  [2,4,6,8].each do |num|
    Table.create!(number: table_num, num_seats: num)
    table_num += 1
  end
end
puts "Done! #{Table.all.size} tables created."

puts "Initializing default customers..."
Customer.destroy_all
(0..4).each do
  Customer.create!(name: Faker::Name.name,
                  phone_number: Faker::PhoneNumber.phone_number)
end
puts "Done! #{Customer.all.size} customers created."

puts "Initializing default reservations..."
Reservation.destroy_all
(0..2).each do |index|
  customer = Customer.all[index]
  table = Table.all[index+3]
  Reservation.create!(customer: customer,
                  table: table,
                  party_size: table.num_seats,
                  requested_datetime: '2015-09-08 14:00:00')
end
puts "Done! #{Reservation.all.size} reservations created."
