require 'rails_helper'

RSpec.describe 'Reality Check Results - Index' do
  describe 'As a visitor, once I have clicked the reality check button and entered my monthlhy income, and hit submit' do
    it 'shows a new set of results that are only listings I could hypothetically afford', :vcr do
      visit root_path

      fill_in :city, with: 'Houston'
      click_button 'Search'

      expect(current_path).to eq(search_path)

      click_button "Reality Check"

      expect(page).to have_content("Enter your monthly income:")

      fill_in :monthly, with: 375000

      click_button "Submit"

      expect(current_path).to eq(reality_check_index_path)

      within('.listings-container') do
        within(first('.listing-item')) do
          within('.photos') do  
            expect(page).to have_css("img[src*='https://s3-us-west-2.amazonaws.com/cdn.simplyrets.com/properties/trial/home4.jpg'][alt='Listing Image']")
          end
          within('.price') do
            expect(page).to have_content("$18,730,333.00")
          end
          within('.listing-info') do
            expect(page).to have_content('68827 South 99 CT Estates #783, Houston, Texas')
            expect(page).to have_content('5')
            expect(page).to have_content('4')
            expect(page).to have_content('3477 m²')
          end

          expect(page).to have_selector(".stretched-link")
          find(".stretched-link").click
      
          expect(current_path).to eq(listing_path(1005172)) # reality check show page once implemented
        end
      end

      expect(page).to_not have_content("60843 South GAITHER WAY CT #18393, Houston, Texas 77532")
      expect(page).to_not have_content("$22,790,088.00")
    end

    it "listings that are not affordable based on the monthly income are not shown", :vcr do
      visit root_path

      fill_in :city, with: 'Houston'
      click_button 'Search'

      click_button "Reality Check"

      fill_in :monthly, with: 375000

      click_button "Submit"

      within('.listings-container') do
        all('.listing-item').each do |listing|
          within(listing) do
            price_text = find('.price').text
            price = price_text.delete('$,').to_i
            expect(price).to be <= 20000000
          end
        end
      end
    end

    it "sad path - no listings found if monthly income is too small", :vcr do
      visit root_path

      fill_in :city, with: 'Houston'
      click_button 'Search'

      click_button "Reality Check"

      fill_in :monthly, with: 1500

      click_button "Submit"

      expect(page).to have_content("No listings found. Want to search for rentals in your area?")
    end
  end
end