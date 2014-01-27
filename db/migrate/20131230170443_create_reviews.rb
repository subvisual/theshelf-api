class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :body, null: false
      t.references :user, index: true, null: false
      t.references :book, index: true, null: false

      t.timestamps
    end
  end
end
