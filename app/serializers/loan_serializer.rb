class LoanSerializer < ActiveModel::Serializer
  attributes :started_at, :ends_at, :closed_at, :closed

  def closed
    object.closed?
  end
end
