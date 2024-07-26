class OomprBeFacade
  def initialize
    @service = OomprBeService.new
  end

  def search_listings_by_city(city)
    results = @service.search_listings_by_city(city)
    
    listings_data = results[:data]
    listings_data.map do |listing|
      Listing.new(listing)
    end
  end
end