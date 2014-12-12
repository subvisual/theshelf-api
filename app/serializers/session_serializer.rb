class SessionSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token
end
