class UserDecorator < Draper::Decorator
  def name
    object.first_name
  end
end
