class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password validations: false
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end