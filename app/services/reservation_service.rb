class ReservationService

  def self.get_reservations
    Reservation.includes(:customer, :table).all
  end

  def self.make_reservation(name, party_size, requested_timestamp)
    tables = get_available_tables(party_size, requested_timestamp)
    raise Exceptions::CapacityError.new if tables.nil? || tables.none?

    customer = Customer.where(name: name).first_or_create
    reservation = Reservation.create(table: tables.first, customer: customer,
          party_size: party_size, requested_datetime: requested_timestamp)
  end

  private

  def self.get_available_tables(party_size, timestamp)
    datetime = DateTime.parse(timestamp)
    time_range = (datetime)..(datetime+59.minutes)
    reserved_tables = Table.includes(:reservations).where(reservations: {requested_datetime: time_range})
    Table.where('num_seats >= ?', party_size) - reserved_tables
  end

end
