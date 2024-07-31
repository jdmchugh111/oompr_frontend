class SearchController < ApplicationController
  def index
    cookies[:city] = {
      value: search_params[:city],
      expires: 24.hours.from_now
    }
    city = cookies[:city]

    @listings = Kaminari.paginate_array(fetch_listings_by_city(city)).page(params[:page]).per(3)

    if @listings.empty?
      flash[:notice] = "No listings found. Please try again."
      redirect_to root_path
    end
  end

  private

  def search_params
    params.permit(:city)
  end

  def fetch_listings_by_city(city)
    cache_key = "search_listings_by_city_#{city}"
    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      OomprBeFacade.new.search_listings_by_city(city)
    end
  end
end
