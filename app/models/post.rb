class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: :true, length: {minimum: 5}
  validates :description, presence: :true
  validates :url, presence: :true, uniqueness: :true

  before_save :generate_slug

  def upvotes
    self.votes.where(vote: true).size
  end

  def downvotes
    self.votes.where(vote: false).size
  end

  def vote_tally
    upvotes - downvotes
  end

  def generate_slug
    self.slug = self.title.gsub(regex).downcase
  end
end