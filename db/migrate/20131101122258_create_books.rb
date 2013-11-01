class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :subtitle
      t.text :summary
      t.integer :pages
      t.string :url
      t.string :authors, null: false
      t.date :published_on
      t.integer :readings
      t.decimal :average_rating, default: 0, precision: 6, scale: 2
      t.string :state, null: false

      t.timestamps
    end
  end
end
