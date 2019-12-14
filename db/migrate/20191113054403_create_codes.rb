class CreateCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :codes do |t|
      t.string :value, null: false
      t.string :name, null: false
      t.string :allowed_time
      t.datetime :disabled_at
      t.references :organization, foreign_key: true, null: false
      t.timestamps null: false
    end

    add_index :codes, [:organization_id, :value], unique: true
  end
end
