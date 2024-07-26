require "rails_helper"

RSpec.describe OomprBeFacade do
  it "exists" do
    facade = OomprBeFacade.new

    expect(facade).to be_a OomprBeFacade
  end

  describe "#search_listings_by_city" do
    it "returns an array of Listing objects", :vcr do
      facade = OomprBeFacade.new
      listings = facade.search_listings_by_city("Houston")

      expect(listings).to be_an Array

      listings.each do |listing|
        expect(listing).to be_a Listing
      end
    end
  end
end