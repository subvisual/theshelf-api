class AddReviewsCounterCacheToBooks < ActiveRecord::Migration
  def change
    add_column :books, :reviews_count, :integer, :default => 0
  end
end
