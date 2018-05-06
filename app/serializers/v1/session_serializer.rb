module V1
  class SessionSerializer < ActiveModel::Serializer
    attributes :raw_token, :user

  end
end