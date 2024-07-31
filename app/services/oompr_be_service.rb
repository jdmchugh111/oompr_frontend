class OomprBeService
  def conn
    Faraday.new(url: "https://whispering-cliffs-26803-3cc31fb2a950.herokuapp.com/api/v1/")
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
    conn.post("favorites?user=#{user}&listing=#{listing}")
  end

  def get_all_favorites(user)
    get_url("favorites?user=#{user}")
  end

  def delete_favorite(favorite)
    conn.delete("favorites/#{favorite}")
  end
end