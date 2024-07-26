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
  end
end