class AddDefaultValueToReadingsInBooks < ActiveRecord::Migration
  def change
    change_column :books, :readings, :integer, default: 0
  end
end
