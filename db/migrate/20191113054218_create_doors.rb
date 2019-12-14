class CreateDoors < ActiveRecord::Migration[6.0]
  def change
    create_table :doors do |t|
      t.string :name, null: false
      t.string :timezone, null: false
      t.string :phone_number, null: false, index: { unique: true }
      t.references :organization, foreign_key: true, null: false
      t.timestamps null: false
    end
  end
end
