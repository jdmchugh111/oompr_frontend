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

  def required_monthly_income(listing_id)
    listing = get_listing_by_id(listing_id)
    monthly_income = ((listing.price * 0.075) / 12) * 3
  end
end