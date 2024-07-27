class ListingsController < ApplicationController
  def show
    @listing = OomprBeFacade.new.get_listing_by_id(params[:id])
  end
end