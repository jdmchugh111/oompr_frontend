class Listing
  attr_reader :id, 
              :price, 
              :address, 
              :bedrooms, 
              :bathrooms, 
              :sqft, 
              :photos
              
  def initialize(data)
    @id = data[:id]
    @price = data[:attributes][:price]
    @address = data[:attributes][:address]
    @bedrooms = data[:attributes][:bedrooms]
    @bathrooms = data[:attributes][:bathrooms]
    @sqft = data[:attributes][:sqft]
    @photos = data[:attributes][:photos]
  end
end