require 'rails_helper'
require 'features/reservations/shared'

feature 'Reservation Listing Page' do

  let(:reservations_page) { ReservationsPage.new }

  scenario 'without any reservations' do
    reservations_page.load
    expect(reservations_page.has_table_message?).to be true
  end

  scenario 'with existing reservations' do
    @reservations = FactoryGirl.create_list(:reservation, 3)
    reservations_page.load
    expect(reservations_page.reservations.size).to eq(3)
  end

end
