require "rails_helper"

RSpec.describe "User Show Page - Dashboard" do
  describe "As a user" do
    it "once I log in, I should be directed to my user dashboard", :vcr do
      visit root_path

      click_link 'Log In'

      # config/initializers/omniauth_test.rb

      expect(page).to have_content('Test User')
      expect(page).to have_content('Saved Listings')
    end

    it "directs to user dashboard when already logged in and name is clicked(in navbar)", :vcr do
      visit root_path

      click_link 'Log In'

      # config/initializers/omniauth_test.rb

      visit root_path

      click_link 'Test User'

      expect(page).to have_content('Test User')
      expect(page).to have_content('Saved Listings')
    end

    it 'each listing will have the address, price, and one picture', :vcr do 
    end

    it "shows message if there are no favorited listings", :vcr do
      visit root_path

      click_link 'Log In'

      # config/initializers/omniauth_test.rb

      expect(page).to have_content('Test User')
      expect(page).to have_content('Saved Listings')

      expect(page).to have_content('You have no saved listings.')
    end
  end
end