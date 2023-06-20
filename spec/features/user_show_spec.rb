require 'rails_helper'

RSpec.describe 'User Page', type: :system do
  let!(:user1) { User.create(name: 'Ameerah', bio: 'Student', photo: 'https://www.shutterstock.com/image-vector/short-custom-urls-url-shortener-600w-2233924609.jpg') }
  let!(:post1) { Post.create(title: 'Ruby on Rails', text: 'I love ruby on rails', author: user1) }
  let!(:post2) do
    Post.create(title: 'Testing on Ruby', text: 'Capybara seems like an interesting test framework', author: user1)
  end
  let!(:post3) do
    Post.create(title: 'Unit Test', text: 'I have worked with RSPEC. Now I am working with Capybara', author: user1)
  end
  let!(:post4) { Post.create(title: 'N+1 Problems', text: 'I solved the N+1 Problem on my code', author: user1) }

  describe 'Show page' do
    before(:each) do
      visit user_path(user1)
    end
    sleep(5)
    it "should display user's profile picture" do
      expect(page).to have_css("img[src='#{user1.photo}']")
    end
    it "should display user's name" do
      expect(page).to have_content(user1.name)
    end

    it 'should display number of posts' do
      expect(page).to have_content("Number of posts: #{user1.post_counter}")
    end
    it 'should display  user bio' do
      expect(page).to have_content(user1.bio)
    end
    it "should display user's recent 3 posts" do
      expect(page).to have_content(post2.title)
      expect(page).to have_content(post3.title)
      expect(page).to have_content(post4.title)
    end
    it 'should display a button to view all posts' do
      expect(page).to have_link('See all Posts', href: user_posts_path(user_id: user1.id))
    end
  end
  describe 'Clicking a post' do
    before(:each) do
      visit user_path(user1)
    end
    it 'should redirect to show page for correct post' do
      click_link(post3.title)
      expect(page).to have_current_path(user_post_path(user_id: user1.id, id: user1.id, author_id: post3.id))
    end
  end

  describe 'Clicking to see all posts' do
    before(:each) do
      visit user_path(user1)
    end
    it "should redirect to user's post's index page" do
      click_link 'See all Posts'
      expect(page).to have_current_path(user_posts_path(user1))
    end
  end
end
