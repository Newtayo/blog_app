require 'rails_helper'

RSpec.describe 'User Page', type: :system do
  let!(:user1) { User.create(name: 'Ameerah', bio: 'Student', photo: 'https://www.shutterstock.com/image-vector/short-custom-urls-url-shortener-600w-2233924609.jpg') }
  let!(:user2) { User.create(name: 'Omotayo', bio: 'Software Developer', photo: 'https://www.shutterstock.com/image-photo/large-thick-industrial-black-metal-600w-1081708619.jpg') }

  describe 'index page' do
    before(:each) do
      visit users_path
      sleep(5)
    end

    it 'should show the list of all users' do
      expect(page).to have_content('List of All Users')
      expect(page).to have_content(user1.name)
      expect(page).to have_content(user2.name)
    end
    it 'should show the number of posts each user has written' do
      expect(page).to have_content(user1.post_counter)
      expect(page).to have_content(user2.post_counter)
    end

    it 'should display all profile pictures' do
      expect(page).to have_css("img[src='#{user1.photo}']")
      expect(page).to have_css("img[src='#{user2.photo}']")
    end
  end

  describe 'Clicking on each user' do
    before(:each) do
      visit users_path
      sleep(5)
    end

    it "should redirect to user's show page" do
      click_link(user1.name)
      expect(page).to have_current_path(user_path(user1.id))
    end
  end
end
