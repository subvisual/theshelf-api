class ReviewDecorator < Draper::Decorator
  delegate :body
  decorates_association :reviewer
end
