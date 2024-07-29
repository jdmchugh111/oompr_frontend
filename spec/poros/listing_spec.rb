require "rails_helper"

RSpec.describe Listing do
  before :each do
    @listing = Listing.new({
      id: "1",
      type: "listing",
      attributes: {
        price: 100000,
        address: "123 MAIN St, HOUSTON TX 77002",
        bedrooms: 3,
        bathrooms: 2,
        sqft: 1500,
        photos: ["photo1.jpg", "photo2.jpg"]
      }
    })
  end

  it "exists with correct data" do
    expect(@listing).to be_a Listing

    expect(@listing.id).to eq("1")
    expect(@listing.id).to be_a String

    expect(@listing.price).to eq(100000)
    expect(@listing.price).to be_an Integer

    expect(@listing.address).to eq("123 MAIN St, HOUSTON TX 77002")
    expect(@listing.address).to be_a String

    expect(@listing.bedrooms).to eq(3)
    expect(@listing.bedrooms).to be_an Integer

    expect(@listing.bathrooms).to eq(2)
    expect(@listing.bathrooms).to be_an Integer

    expect(@listing.sqft).to eq(1500)
    expect(@listing.sqft).to be_an Integer

    expect(@listing.photos).to eq(["photo1.jpg", "photo2.jpg"])
    expect(@listing.photos).to be_an Array
  end
end