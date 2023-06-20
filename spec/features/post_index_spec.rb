require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
  let!(:user) { User.create(name: 'Rilwan', bio: 'Engineer', photo: 'https://www.shutterstock.com/image-vector/short-custom-urls-url-shortener-600w-2233924609.jpg') }
  let!(:post1) { Post.create(title: 'Post Title 1', text: 'My post dummy content 1', author: user) }
  let!(:post2) { Post.create(title: 'Post Title 2', text: 'My post dummy content 2', author: user) }
  let!(:post3) { Post.create(title: 'Post Title 3', text: 'My post dummy content 3', author: user) }
  let!(:comment1) { Comment.create(author: user, post: post1, text: 'My comment 1') }
  let!(:comment2) { Comment.create(author: user, post: post1, text: 'My comment 2') }
  let!(:comment3) { Comment.create(author: user, post: post1, text: 'My comment 3') }
  let!(:likes) do
    Array.new(3) { Like.create(post: post2, author: user) }
  end

  describe 'Page content' do
    before do
      visit user_posts_path(user)
    end
    it "should display user's profile picture" do
      expect(page).to have_css("img[src='#{user.photo}']")
    end
    it "should display user's name" do
      expect(page).to have_content(user.name)
    end

    it 'should display number of posts' do
      expect(page).to have_content("Number of posts: #{user.post_counter}")
    end

    it 'should display all post titles' do
      expect(page).to have_content(post1.title)
      expect(page).to have_content(post2.title)
      expect(page).to have_content(post3.title)
    end

    it "should display some of posts' content" do
      expect(page).to have_content(post1.text[0..100])
      expect(page).to have_content(post2.text[0..100])
      expect(page).to have_content(post3.text[0..100])
    end

    it 'should display recent comments on a post' do
      expect(page).to have_content(comment1.text)
      expect(page).to have_content(comment2.text)
      expect(page).to have_content(comment3.text)
    end

    it 'should display comment counts for each post' do
      expect(page).to have_content("Comments: #{post1.comments_counter}")
      expect(page).to have_content("Comments: #{post2.comments_counter}")
      expect(page).to have_content("Comments: #{post3.comments_counter}")
    end

    it 'should display total likes for a post' do
      expect(page).to have_content("Likes: #{post2.likes_counter}")
    end
    it 'should have a button for pagination' do
      expect(page).to have_button('Pagination')
    end
    describe 'Clicking on a post' do
      it "should redirect to correct post's show page" do
        click_link post2.title
        expect(page).to have_current_path(user_post_path(user_id: user.id, id: post2.id, author_id: post2.id))
      end
    end
  end
end
