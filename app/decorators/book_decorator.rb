class BookDecorator < Draper::Decorator
  delegate :average_rating, :authors, :id, :pages, :published_on, :readings,
    :state, :subtitle, :summary, :title, :url, :available?, :lent?,
    :unavailable?, :to_model

  def availability
    h.t("books.state.#{state}")
  end

  def current_borrower
    object.current_borrower.decorate
  end

  def path
    h.book_path(object)
  end

  def borrow_path
    h.borrow_book_path(object)
  end
end
