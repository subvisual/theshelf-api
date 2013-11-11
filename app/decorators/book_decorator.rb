class BookDecorator < Draper::Decorator
  delegate :average_rating, :authors, :id, :pages, :published_on, :readings,
    :state, :subtitle, :summary, :title, :url, :available?, :lent?,
    :unavailable?, :to_model

  def availability
    h.t("books.state.#{state}")
  end

  def path
    h.book_path(object)
  end
end
