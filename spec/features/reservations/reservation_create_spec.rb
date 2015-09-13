require 'rails_helper'
require 'features/reservations/shared'

feature 'Reservation Create Page' do

  include_context 'reservations'

  before do
    reservations_page.load
  end

  let(:name) { 'Bill Gates' }
  let(:party_size) { 2 }
  let(:timestamp) { "2015-09-03 14:00:00" }
  let(:reservations_page) { ReservationsPage.new }

  scenario 'successful reservation' do
    reservations_page.create_reservation_for(name, party_size, timestamp)
    expect(reservations_page.has_success_message?).to be true
    expect(reservations_page.reservations.size).to eq(4)
  end

  scenario 'unsuccessful reservation' do
    reservations_page.create_reservation_for('', '', timestamp)
    expect(reservations_page.has_error_message?).to be true
    expect(reservations_page.reservations.size).to eq(3)
  end

end
