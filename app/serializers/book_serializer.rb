class BookSerializer < ActiveModel::Serializer
  attributes :id, :isbn, :title, :authors, :cover_path, :owner, :total_reviews

  def cover_path
    object.cover.url
  end
end
