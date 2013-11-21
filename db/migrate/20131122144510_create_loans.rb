class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.references :user, null: false
      t.references :book, null: false
      t.datetime :started_at
      t.datetime :ends_at
      t.datetime :closed_at
    end
    add_index :loans, :book_id
    add_index :loans, :user_id
  end
end
