class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:index, :create]
  before_action :load_all_reservations, only: [:index]

  rescue_from Exceptions::CapacityError, :with => :render_capacity_error

  def index; end

  def create
    unless @reservation.validate(reservation_params.merge(customer: customer_params))
      load_all_reservations
      render :index and return
    end

    name = customer_params[:name]
    party_size = reservation_params[:party_size]
    requested_timestamp = DateTime.civil(reservation_params["requested_datetime(1i)"].to_i,
      reservation_params["requested_datetime(2i)"].to_i,
      reservation_params["requested_datetime(3i)"].to_i,
      reservation_params["requested_datetime(4i)"].to_i,
      reservation_params["requested_datetime(5i)"].to_i,
      reservation_params["requested_datetime(6i)"].to_i).to_s

    @reservation = ReservationService.make_reservation(name, party_size, requested_timestamp)
    redirect_to reservations_path, reservation_id: @reservation.id, notice: 'Reservation was successfully created.'
  end

  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_path, notice: 'Reservation was successfully cancelled.' }
      format.json { head :no_content }
    end
  end

  def render_capacity_error
    load_all_reservations
    flash.now[:alert] = 'Sorry, the reservation could not be made. Max capacity has been reached.'
    render 'index'
  end

  private

    def set_reservation
      @reservation = ReservationForm.new(Reservation.new(customer: Customer.new(name: '')))
    end

    def load_all_reservations
      @reservations = ReservationService.get_reservations
    end

    def reservation_params
      params.require(:reservation).permit(:name, :party_size, :requested_datetime)
    end

    def customer_params
      params.require(:customer).permit(:name)
    end
end
