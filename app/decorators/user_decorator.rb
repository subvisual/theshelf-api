class UserDecorator < Draper::Decorator
  def name
    object.first_name
  end

  def ==(other)
    object == other.object
  end
end
