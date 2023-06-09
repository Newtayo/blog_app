class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, class_name: 'Like'
  has_many :comments

  after_save :update_posts_count
  after_destroy :delete_posts_count

  before_validation :initialize_counters

  def update_posts_count
    author.increment!(:post_counter)
  end

  def delete_posts_count
    author.decrement!(:post_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
                            message: 'must be an integer greater than or equal to zero.' }
  validates :likes_counter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
                            message: 'must be an integer greater than or equal to zero.' }

  private

  def initialize_counters
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end
