require "rails_helper"

RSpec.describe "Listing Show Page" do
  describe "As a visitor, when I'm on the search results page" do
    it "when I click on a listing I'm brought to that listing's show page", :vcr do
      visit root_path

      fill_in :city, with: 'Houston'
      click_button 'Search'

      within('.listings-container') do
        within(first('.listing-item')) do
          find(".stretched-link").click
        end
      end

      expect(current_path).to eq(listing_path(1005254))
    end

    it 'title is a link to the landing page', :vcr do
      visit listing_path(1005254)

      within('h1.oompr-title') do
        title_link = find('a.oompr-title-link')
        expect(title_link[:href]).to eq(root_path)
      end
    end

    it "on the listing show page I see all the same attributes", :vcr do
      visit listing_path(1005254)

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
    end

    it "there is a heart icon that I can click to save the listing to favorites (if signed in)" do      
    end

    it "if not signed in, clicking the heart prompts me to create an account or sign in" do
    end

    describe "Reality Check" do
      it "I should see a 'Reality Check' button", :vcr do
        visit listing_path(1005254)

        within('.rc-button') do
          expect(page).to have_button("Reality Check")
        end
      end

      it "clicking the 'Reality Check' button shows a number field and prompts me to enter my monthly income,
      when the submit button is clicked, a modal should pop up and show what I make, versus what I would need to make", :vcr do
        visit listing_path(1005254)

        click_button "Reality Check"

        expect(page).to have_content("Enter your monthly income:")

        fill_in :monthly, with: 375000

        click_button "Submit"

        expect(page).to have_css('.modal', visible: true)

        within('.modal-body') do
          expect(page).to have_content("What You Make:")
          expect(page).to have_content("What You Would Need To Make:")
        end
      end

      it "if I have previously entered my monthly income, that number should be stored in a cookie", :vcr do
        visit listing_path(1005254)

        click_button "Reality Check"

        fill_in :monthly, with: 375000

        click_button "Submit"

        visit listing_path(1005254)

        click_button "Reality Check"

        expect(find_field(:monthly).value).to eq('375000')
      end
    end
  end
end

# As a user, if I'm on a listing show page
# I should see a "Reality Check" button
# When I click it, a number field appears and I'm prompted to enter my monthly income
# (Unless I have previously entered my monthly income, in which case that number should be stored in a cookie)
# Once submitted, the Reality Check should display:
# "What You Make: $XXX"
# "What You Would Need To Make: $XXX"

# maybe just make modal that pops up to tell prices instead of a whole new page?
# how to store the monthly income in a cookie using the modal, since not going to a controller?