class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :number, null: false
      t.integer :num_seats, default: 2

      t.timestamps null: false
    end
  end
end
