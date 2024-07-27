class ListingsController < ApplicationController
  def show
    @listing = OomprBeFacade.new.get_listing_by_id(listing_params[:id])
  end

  private
  def listing_params
    params.permit(:id)
  end
end