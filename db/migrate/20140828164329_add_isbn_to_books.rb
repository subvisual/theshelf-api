class AddIsbnToBooks < ActiveRecord::Migration
  def change
    add_column :books, :isbn, :string
    add_index :books, :isbn
  end
end
