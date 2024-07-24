require 'rails_helper'

RSpec.describe 'Landing Page, Welcome Index' do
  describe 'As a visitor, when I visit the landing page' do
    it "shows the oompr logo" do
      visit root_path

      expect(page).to have_content('oompr')
    end

    it 'I see a search field where I can enter a city name' do # context?
      visit root_path

      expect(page).to have_field(:city)
      expect(page).to have_button('Search')
    end

    it 'I click the search button, brings me to the search results page' do
      visit root_path

      fill_in :city, with: 'Houston'
      click_button 'Search'

      expect(current_path).to eq(search_path)
    end
  end
end