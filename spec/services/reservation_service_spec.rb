require 'rails_helper'

RSpec.describe ReservationService do

  describe "#get_reservations" do

    before do
      FactoryGirl.create_list :reservation, 3
    end

    let(:reservations) { ReservationService.get_reservations() }

    subject { reservations }

    it { is_expected.to_not be_empty }
    its(:size) { should eq(3) }

  end

  describe "#make_reservation" do

    let(:customer) { FactoryGirl.build :customer }
    let(:party_size) { 4 }
    let(:requested_timestamp) { "2015-09-03 14:00:00" }

    context "when a table is available" do

      context "and there are enough seats" do

        before do
          FactoryGirl.create :table, number: 1, num_seats: 4
        end

        it "should return a confirmed reservation" do
          expect {
            ReservationService.make_reservation(customer.name, party_size, requested_timestamp)
          }.to change(Reservation, :count).by(1)
        end

      end

      context "and there are not enough seats" do

        before do
          FactoryGirl.create :table, number: 1, num_seats: 2
        end

        it "it should return an error", focus: true do
          expect {
            ReservationService.make_reservation(customer.name, party_size, requested_timestamp)
          }.to raise_error(Exceptions::CapacityError)
        end

      end

    end

  end

end
