class SearchController < ApplicationController
  def index
    @facade = OomprBeFacade.new
    @listings = @facade.search_listings_by_city(search_params[:city])
    if @listings.empty?
      flash[:notice] = "No listings found. Please try again." 
      redirect_to root_path
    end
    cookies[:city] = search_params[:city]
  end
  
  private
  def search_params
    params.permit(:city)
  end
end