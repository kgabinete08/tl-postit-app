class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, confirmation: true, on: :create, length: {minimum: 5}
  validates :password_confirmation, presence: true, on: :create

  before_save :generate_slug

  sluggable_column :username

  def admin?
    self.role == 'admin'
  end
end