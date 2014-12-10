class LoanSerializer < ActiveModel::Serializer
  attributes :started_at, :ends_at, :closed_at, :closed, :extended

  def closed
    object.closed?
  end

  def extended
    object.extended?
  end
end
