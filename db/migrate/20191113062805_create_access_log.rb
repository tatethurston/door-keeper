class CreateAccessLog < ActiveRecord::Migration[6.0]
  def change
    create_table :access_logs do |t|
      t.references :door, foreign_key: true, null: false
      t.references :code, foreign_key: true
      t.boolean :success, null: false
      t.string :denied_reason
      t.timestamps null: false
    end
  end
end
