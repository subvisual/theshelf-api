class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :value, null: false
      t.references :book, null: false, index: true
      t.references :user, null: false, index: true

      t.timestamps
    end
  end
end
