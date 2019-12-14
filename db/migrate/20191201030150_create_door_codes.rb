class CreateDoorCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :doors_codes do |t|
      t.references :door, foreign_key: true, null: false
      t.references :code, foreign_key: true, null: false
    end

    add_index :doors_codes, [:door_id, :code_id], unique: true
  end
end
