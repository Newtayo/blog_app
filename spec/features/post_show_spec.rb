require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  let!(:user) { User.create(name: 'Omotayo', bio: 'Full-Stack Developer', photo: 'https://www.shutterstock.com/image-vector/short-custom-urls-url-shortener-600w-2233924609.jpg') }
  let!(:post) { Post.create(title: 'My Post Title', text: 'My post dummy content', author: user) }
  let!(:comment) { Comment.create(author: user, post:, text: 'My comment') }
  let!(:likes) { Like.create(author: user, post:) }

  describe 'Page content' do
    it "should display post's title" do
      visit user_post_path(user_id: user.id, id: post.id, author_id: post.id)
      expect(page).to have_content(post.title)
    end

    it 'should display Author of the post' do
      visit user_post_path(user_id: user.id, id: post.id, author_id: post.id)
      expect(page).to have_content(user.name)
    end

    it 'should display Number of Likes of the post' do
      visit user_post_path(user_id: user.id, id: post.id, author_id: post.id)
      expect(page).to have_content(post.likes_counter)
    end

    it 'should display the username of each commenter' do
      visit user_post_path(user_id: user.id, id: post.id, author_id: post.id)
      expect(page).to have_content(comment.author.name)
    end
    it 'should display the username of each commentor' do
      visit user_post_path(user_id: user.id, id: post.id, author_id: post.id)
      expect(page).to have_content(comment.author.name)
    end

    it 'should display the comments each commentor left' do
      visit user_post_path(user_id: user.id, id: post.id, author_id: post.id)
      expect(page).to have_content(comment.text)
    end

    it 'should display comment counts for each post' do
      visit user_post_path(user_id: user.id, id: post.id, author_id: post.id)
      expect(page).to have_content("Comments: #{post.comments_counter}")
    end
  end
end
