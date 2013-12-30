class BookDecorator < Draper::Decorator
  delegate :authors, :cover, :cover_cache, :id,
    :last_review_by, :pages, :published_on, :readings, :reviews_by, :state,
    :subtitle, :summary, :title, :total_reviews, :url, :available?, :lent?,
    :unavailable?, :to_model
  decorates_association :reviews

  def action
    if object.available?
      borrow_link
    elsif object.lent?
      lent_actions
    end
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

  private

  def lent_actions
    if borrowed_by_me?
      return_link
    else
      h.content_tag :span, current_borrower.name, class: 'milli borrowed'
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
end
