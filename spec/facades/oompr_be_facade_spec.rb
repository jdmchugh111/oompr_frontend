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

  describe "#get_listing_by_id" do
    it "returns a Listing object", :vcr do
      facade = OomprBeFacade.new
      listing = facade.get_listing_by_id(1005254)

      expect(listing).to be_a Listing
    end
  end

  describe "#reality_check" do
    it "returns an array of Listing objects that match the city and price range", :vcr do
      rc_listings = OomprBeFacade.new.reality_check("Houston", 375000)

      rc_listings.each do |listing|
        expect(listing).to be_a Listing
      end

      expect(rc_listings[0].price).to be <= 20000000
    end
  end
end