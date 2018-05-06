class User < ApplicationRecord
  has_secure_password

  has_many :sessions

  enum position: [:doctor, :patient]
end
