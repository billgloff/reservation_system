class ReservationsPage < SitePrism::Page
  set_url "/"

  elements :reservations, "[class='reservations_list_item']"

  element :success_message, "[class='alert alert-success']"
  element :error_message, "[class='alert alert-danger']"
  element :table_message, "[id='table_message']"

  element :name_field, "input[name='customer[name]']"
  element :party_field, "input[name='reservation[party_size]']"

  def create_reservation_for(name, party_size, timestamp)
    name_field.set name
    party_field.set party_size
    click_on('Make Reservation')
    SearchResultsPage.new
  end

end
