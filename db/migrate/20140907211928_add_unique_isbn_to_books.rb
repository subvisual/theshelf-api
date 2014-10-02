class AddUniqueIsbnToBooks < ActiveRecord::Migration
  def change
    remove_index :books, :isbn
    add_index :books, :isbn, unique: true
  end
end
