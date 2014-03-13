class UserDecorator < Draper::Decorator
  delegate :avatar

  def name
    "#{object.first_name} #{object.last_name}"
  end

  def currently_borrowed_books
    object.currently_borrowed_books.decorate
  end

  def ==(other)
    object == other.object
  end
end
