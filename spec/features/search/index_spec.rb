require 'rails_helper'

RSpec.describe 'Search Results - Index' do
  describe 'As a visitor, once I have entered a city and clicked the search button on the landing page' do
    it "shows the search results page with the listings sorted by most expensive, each listing includes: 
    price, address, # bedrooms, # bathrooms, square footage, and all photos, each listing is a link to that
    listing's show page", :vcr do
      visit root_path

      fill_in :city, with: 'Houston'
      click_button 'Search'

      within('.listings-container') do
        within(first('.listing-item')) do
          within('.photos') do  
            expect(page).to have_css("img[src*='https://s3-us-west-2.amazonaws.com/cdn.simplyrets.com/properties/trial/home4.jpg'][alt='Listing Image']")
          end
          within('.price') do
            expect(page).to have_content("$22,790,088.00")
          end
          within('.listing-info') do
            expect(page).to have_content('60843 South GAITHER WAY CT #18393, Houston, Texas 77532')
            expect(page).to have_content('4')
            expect(page).to have_content('2')
            expect(page).to have_content('1623 m²')
          end

          expect(page).to have_selector(".stretched-link")
          find(".stretched-link").click
      
          expect(current_path).to eq(listing_path(1005254))
        end

        expect("$22,790,088.00").to appear_before("$20,714,261.00")
        expect("$20,714,261.00").to appear_before("$20,683,471.00") 
      end
    end

    it 'displays the title as a link to the landing page', :vcr do
      visit root_path

      fill_in :city, with: 'Houston'
      click_button 'Search'
      
      within('h1.oompr-title') do
        title_link = find('a.oompr-title-link')
        expect(title_link[:href]).to eq(root_path)
      end
    end
  end

  describe "sad path - no listings found", :vcr do
    it "shows a flash message saying that no listings were found,
    redirects to landing page" do
      visit root_path

      fill_in :city, with: 'asdf'
      click_button 'Search'

      expect(page).to have_content('No listings found. Please try again.')
      expect(current_path).to eq(root_path)
    end
  end

  describe "sad path - no listings found - empty search", :vcr do
    it "shows a flash message saying that no listings were found,
    redirects to landing page" do
      visit root_path

      fill_in :city, with: ''
      click_button 'Search'

      expect(page).to have_content('No listings found. Please try again.')
      expect(current_path).to eq(root_path)
    end
  end

  describe "Realty Check", :vcr do
    it "shows a 'Reality Check' button", :vcr do
      visit root_path

      fill_in :city, with: 'Houston'
      click_button 'Search'

      within('.rc-button') do
        expect(page).to have_button("Reality Check")
      end
    end

    it "clicking the 'Reality Check' button shows a number field and prompts the user to enter their monthly income,
    when the submit button is clicked, a new set of results show that are affordable based on income entered", :vcr do
      visit root_path
      
      fill_in :city, with: 'Houston'
      click_button 'Search'

      expect(current_path).to eq(search_path)

      click_button "Reality Check"

      expect(page).to have_content("Enter your monthly income:")

      expect(page).to have_field("monthly")
      fill_in :monthly, with: 375000

      expect(page).to have_button("Submit")
      click_button "Submit"

      expect(current_path).to eq(reality_check_index_path)
    end
  end
end