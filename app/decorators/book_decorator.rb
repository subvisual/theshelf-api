class BookDecorator < Draper::Decorator
  delegate :state, :title, :average_rating, :authors,
    :available?, :lent?, :unavailable?

  def availability
    h.t("books.state.#{state}")
  end

  def path
    h.book_path(object)
  end
end
