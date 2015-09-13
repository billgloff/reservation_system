class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :customer, index: true, foreign_key: true, null: false
      t.references :table, index: true, foreign_key: true, null: false
      t.integer :party_size
      t.timestamp :requested_datetime, null: false

      t.timestamps null: false
    end
  end
end
