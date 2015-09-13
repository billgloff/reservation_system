FactoryGirl.define do

  factory :reservation do
    customer
    table
    party_size 2
    requested_datetime "2015-09-03 14:00:00"
  end

end
