require 'reform'

class ReservationForm < Reform::Form
  include Reform::Form::ActiveRecord
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::FormBuilderMethods

  property :party_size
  validates :party_size, presence: true

  property :requested_datetime

  property :customer do
    property :name
    validates :name, presence: true
  end

end
