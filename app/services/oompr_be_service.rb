class OomprBeService
  def conn
    Faraday.new(url: "http://localhost:3000/api/v1/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def search_listings_by_city(city)
    get_url("properties?city=#{city}")
  end

  def get_listing_by_id(id)
    get_url("properties/#{id}")
  end

  def reality_check(city, monthly)
    get_url("properties?city=#{city}&monthly=#{monthly}")
  end

  def new_favorite(user, listing)
    Faraday.post("http://localhost:3000/api/v1/favorites?user=#{user}&listing=#{listing}")
  end
end