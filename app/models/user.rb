class User < ApplicationRecord
  # bycypt
  has_secure_password

  # models Associations
  has_many :searchs

  validates_presence_of :public_id, :name, :picture_thumbnail, :password_digest
end
