class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :password, confirmation: true, on: :create, length: {minimum: 5}
  validates :password_confirmation, presence: true
end