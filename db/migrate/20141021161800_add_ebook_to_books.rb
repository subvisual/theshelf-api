class AddEbookToBooks < ActiveRecord::Migration
  def change
    add_column :books, :ebook, :string
  end
end
