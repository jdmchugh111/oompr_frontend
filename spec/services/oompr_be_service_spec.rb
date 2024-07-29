require "rails_helper"

RSpec.describe OomprBeService do
  describe "initialize" do
    it "exists" do
      service = OomprBeService.new
  
      expect(service).to be_a OomprBeService
    end
  end

  describe "#conn" do
    it "creates a Faraday connection" do
      connection = OomprBeService.new.conn

      expect(connection).to be_a Faraday::Connection
    end
  end

  describe "#get_url", :vcr do
    it "returns the results from the API call" do
      response = OomprBeService.new.get_url("properties?city=Houston")

      listings_data = response[:data]

      expect(listings_data).to be_an Array
      
      listings_data.each do |listing|
        expect(listing).to have_key(:id)
        expect(listing[:id]).to be_a String

        expect(listing).to have_key(:type)
        expect(listing[:type]).to eq("listing")

        expect(listing).to have_key(:attributes)
        expect(listing[:attributes]).to be_a Hash

        expect(listing[:attributes]).to have_key(:price)
        expect(listing[:attributes][:price]).to be_an Integer

        expect(listing[:attributes]).to have_key(:address)
        expect(listing[:attributes][:address]).to be_a String

        expect(listing[:attributes]).to have_key(:bedrooms)
        expect(listing[:attributes][:bedrooms]).to be_an Integer

        expect(listing[:attributes]).to have_key(:bathrooms)
        expect(listing[:attributes][:bathrooms]).to be_an Integer

        expect(listing[:attributes]).to have_key(:sqft)
        expect(listing[:attributes][:sqft]).to be_an Integer

        expect(listing[:attributes]).to have_key(:photos)
        expect(listing[:attributes][:photos]).to be_an Array
        listing[:attributes][:photos].each do |photo|
          expect(photo).to be_a String
        end
      end
    end

    it "sad path - returns an empty array if the city is not found", :vcr do
      response = OomprBeService.new.get_url("properties?city=asdf")

      expect(response[:data]).to eq([])
    end
  end

  describe "#search_listings_by_city", :vcr do
    it "returns an array of listings data from city searched" do
      listings = OomprBeService.new.search_listings_by_city("Houston")[:data]

      expect(listings).to be_an Array

      listings.each do |listing|
        expect(listing).to be_a Hash

        expect(listing).to have_key(:id)
        expect(listing[:id]).to be_a String

        expect(listing).to have_key(:type)
        expect(listing[:type]).to eq("listing")

        expect(listing).to have_key(:attributes)
        expect(listing[:attributes]).to be_a Hash

        expect(listing[:attributes]).to have_key(:price)
        expect(listing[:attributes][:price]).to be_an Integer

        expect(listing[:attributes]).to have_key(:address)
        expect(listing[:attributes][:address]).to be_a String

        expect(listing[:attributes]).to have_key(:bedrooms)
        expect(listing[:attributes][:bedrooms]).to be_an Integer

        expect(listing[:attributes]).to have_key(:bathrooms)
        expect(listing[:attributes][:bathrooms]).to be_an Integer

        expect(listing[:attributes]).to have_key(:sqft)
        expect(listing[:attributes][:sqft]).to be_an Integer

        expect(listing[:attributes]).to have_key(:photos)
        expect(listing[:attributes][:photos]).to be_an Array
        listing[:attributes][:photos].each do |photo|
          expect(photo).to be_a String
        end
      end
    end

    it "sad path - returns an empty array if the city is not found", :vcr do
      listings = OomprBeService.new.search_listings_by_city("asdf")[:data]

      expect(listings).to eq([])
    end
  end

  describe "#get_listing_by_id", :vcr do
    it "returns a Listing object with an id that matches id passed in" do
      listing = OomprBeService.new.get_listing_by_id(1005254)[:data]
      
      expect(listing).to be_a Hash

      expect(listing).to have_key(:id)
      expect(listing[:id]).to be_a String

      expect(listing).to have_key(:type)
      expect(listing[:type]).to eq("listing")

      expect(listing).to have_key(:attributes)
      expect(listing[:attributes]).to be_a Hash

      expect(listing[:attributes]).to have_key(:price)
      expect(listing[:attributes][:price]).to be_an Integer

      expect(listing[:attributes]).to have_key(:address)
      expect(listing[:attributes][:address]).to be_a String

      expect(listing[:attributes]).to have_key(:bedrooms)
      expect(listing[:attributes][:bedrooms]).to be_an Integer

      expect(listing[:attributes]).to have_key(:bathrooms)
      expect(listing[:attributes][:bathrooms]).to be_an Integer

      expect(listing[:attributes]).to have_key(:sqft)
      expect(listing[:attributes][:sqft]).to be_an Integer

      expect(listing[:attributes]).to have_key(:photos)
      expect(listing[:attributes][:photos]).to be_an Array
      listing[:attributes][:photos].each do |photo|
        expect(photo).to be_a String
      end
    end

    it "sad path - returns an empty hash if the id is not found", :vcr do
      listing = OomprBeService.new.get_listing_by_id(99999)

      expect(listing).to have_key(:errors)

      expect(listing[:errors][0]).to have_key(:code)
      expect(listing[:errors][0][:code]).to eq(404)
      
      expect(listing[:errors][0]).to have_key(:message)
      expect(listing[:errors][0][:message]).to eq("Resource not found")
    end
  end

  describe "#reality_check" do
    it "returns an array of Listing objects that match the city and price range", :vcr do
      rc_listings = OomprBeService.new.reality_check("Houston", 375000)[:data]

      expect(rc_listings.count).to be <= 50

      expect(rc_listings[0][:attributes][:price]).to be <= 20000000

      expect(rc_listings).to be_an Array

      rc_listings.each do |listing|
        expect(listing).to be_a Hash

        expect(listing).to have_key(:id)
        expect(listing[:id]).to be_a String

        expect(listing).to have_key(:type)
        expect(listing[:type]).to eq("listing")

        expect(listing).to have_key(:attributes)
        expect(listing[:attributes]).to be_a Hash

        expect(listing[:attributes]).to have_key(:price)
        expect(listing[:attributes][:price]).to be_an Integer

        expect(listing[:attributes]).to have_key(:address)
        expect(listing[:attributes][:address]).to be_a String

        expect(listing[:attributes]).to have_key(:bedrooms)
        expect(listing[:attributes][:bedrooms]).to be_an Integer

        expect(listing[:attributes]).to have_key(:bathrooms)
        expect(listing[:attributes][:bathrooms]).to be_an Integer

        expect(listing[:attributes]).to have_key(:sqft)
        expect(listing[:attributes][:sqft]).to be_an Integer

        expect(listing[:attributes]).to have_key(:photos)
        expect(listing[:attributes][:photos]).to be_an Array
        listing[:attributes][:photos].each do |photo|
          expect(photo).to be_a String
        end
      end
    end

    it "sad path - returns an empty array if the city is not found", :vcr do
      rc_listings = OomprBeService.new.reality_check("asdf", 375000)

      expect(rc_listings[:data]).to eq([])
    end

    it "sad path - returns an empty array if monthly income is too low", :vcr do
      rc_listings = OomprBeService.new.reality_check("Houston", 1500)

      expect(rc_listings[:data]).to eq([])
    end
  end
end