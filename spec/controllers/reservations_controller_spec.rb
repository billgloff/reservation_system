require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  render_views

  let(:valid_attributes) {
    {party_size: 2, "requested_datetime(1i)"=>"2015", "requested_datetime(2i)"=>"9",
      "requested_datetime(3i)"=>"6", "requested_datetime(4i)"=>"05", "requested_datetime(5i)"=>"00"}
  }

  let(:invalid_attributes) {
    {party_size: '', "requested_datetime(1i)"=>"2015", "requested_datetime(2i)"=>"9",
      "requested_datetime(3i)"=>"6", "requested_datetime(4i)"=>"05",
      "requested_datetime(5i)"=>"00"}
  }

  let(:customer_attributes) {
    {customer: {name: 'Bill Gates'}}
  }

  let(:customer) {
    Customer.create! name: 'Bill Gates'
  }

  let(:table) {
    Table.create! number: 1, num_seats: 2
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all reservations as @reservations" do
      reservation = Reservation.create! valid_attributes.merge(customer: customer, table: table)
      get :index, {}, valid_session
      expect(assigns(:reservations)).to eq([reservation])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Reservation" do
        expect {
          Table.create! number: 1, num_seats: 2
          post :create, {reservation: valid_attributes}.merge(customer_attributes), valid_session
        }.to change(Reservation, :count).by(1)
      end

      it "assigns a newly created reservation as @reservation" do
        Table.create! number: 1, num_seats: 2
        post :create, {reservation: valid_attributes}.merge(customer_attributes), valid_session
        expect(assigns(:reservation)).to be_a(Reservation)
        expect(assigns(:reservation)).to be_persisted
      end

      it "redirects to the created reservation" do
        post :create, {reservation: valid_attributes}.merge(customer_attributes), valid_session
        expect(response).to render_template(:index)
      end
    end

    context "with invalid params" do
      it "re-renders the 'index' template", focus: true do
        post :create, {:reservation => invalid_attributes}.merge(customer_attributes), valid_session
        expect(response).to render_template(:index)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested reservation" do
      reservation = Reservation.create! valid_attributes.merge(customer: customer, table: table)
      expect {
        delete :destroy, {:id => reservation.to_param}, valid_session
      }.to change(Reservation, :count).by(-1)
    end

    it "redirects to the reservations list" do
      reservation = Reservation.create! valid_attributes.merge(customer: customer, table: table)
      delete :destroy, {:id => reservation.to_param}, valid_session
      expect(response).to redirect_to(reservations_url)
    end
  end

end
