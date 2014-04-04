class AddOwnerToBooks < ActiveRecord::Migration
  def change
    add_column :books, :owner, :string
  end
end
