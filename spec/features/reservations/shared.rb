shared_context "reservations" do
  before { @reservations = FactoryGirl.create_list(:reservation, 3) }
end
