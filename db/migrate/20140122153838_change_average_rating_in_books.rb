class ChangeAverageRatingInBooks < ActiveRecord::Migration
  def change
    change_column :books, :average_rating, :decimal, precision: 2, scale: 1, default: 0.0
  end
end
