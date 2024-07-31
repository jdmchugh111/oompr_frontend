class Favorite
  attr_reader :id,
              :listing_id,
              :address,
              :price,
              :picture
              
  def initialize(data)
    @id = data[:id]
    @listing_id = data[:attributes][:listing_id]
    @address = data[:attributes][:address]
    @price = data[:attributes][:price]
    @picture = data[:attributes][:picture]
  end
end