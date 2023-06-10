class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_save :update_like_count

  private

  def update_like_count
    Post.increment_counter(:likes_counter, post_id)
  end
end
