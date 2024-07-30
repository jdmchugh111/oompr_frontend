class OomprBeFacade
  def initialize
    @service = OomprBeService.new
  end

  def search_listings_by_city(city)
    listings_data = @service.search_listings_by_city(city)
    listings_data[:data].map do |listing|
      Listing.new(listing)
    end
  end

  def get_listing_by_id(id)
    listing = @service.get_listing_by_id(id)
    Listing.new(listing[:data])
  end

  def reality_check(city, monthly)
    rc_listings_data = @service.reality_check(city, monthly)
    rc_listings_data[:data].map do |listing|
      Listing.new(listing)
    end
  end

  def geocoder_key
    Rails.application.credentials.geocoder[:key]
  end
end