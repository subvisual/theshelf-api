class BookDecorator < Draper::Decorator
  delegate :authors, :cover, :cover_cache, :id, :last_review_by, :owner,
    :pages, :published_on, :readings, :reviews_by, :state, :subtitle, :summary,
    :title, :total_reviews, :url, :average_rating, :available?, :lent?,
    :unavailable?, :to_model
  decorates_association :reviews

  def action
    if object.available?
      borrow_link
    elsif object.lent?
      lent_actions
    end
  end

  def average_rating
    object.average_rating.round(1).to_s
  end

  def rating_values
    RatingValues.all
  end

  def rating_by(rater)
    object.rating_by(rater.model).value
  end

  def path
    h.book_path(object)
  end

  def borrow_path
    h.borrow_book_path(object)
  end

  def return_path
    h.return_book_path(object)
  end

  def edit_path
    h.edit_book_path(object)
  end

  def as_json
    {
      path: path,
      cover_path: cover.url,
      title: title,
      owner: owner,
      authors: authors,
      total_reviews: h.t('reviews.total_reviews', count: total_reviews),
      rating_show: h.render('rating_show', book: self, rating_value: average_rating),
      action: action
    }.to_json
  end

  private

  def lent_actions
    if borrowed_by_me?
      return_link
    else
      h.content_tag(:div, class: 'borrower') do
        h.content_tag(:div, h.image_tag(current_borrower.avatar.thumb)) +
        h.content_tag(:div, current_borrower.name, class: 'milli')
      end
    end
  end

  def borrowed_by_me?
    current_borrower == h.presented_current_user
  end

  def current_borrower
    object.current_borrower.decorate
  end

  def borrow_link
    h.link_to h.t('books.actions.borrow'), borrow_path, class: 'btn-positive'
  end

  def return_link
    h.link_to h.t('books.actions.return'), return_path, class: 'btn-negative'
  end

  def edit_link
    h.link_to h.t('books.actions.edit'), edit_path
  end
end
