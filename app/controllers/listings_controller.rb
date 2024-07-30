class ListingsController < ApplicationController
  def show
    @listing = OomprBeFacade.new.get_listing_by_id(listing_params[:id])
  end

  def reality_check
    cookies[:monthly] = {
      value: params[:monthly],
      expires: 24.hours.from_now
    }

    required_income = OomprBeFacade.new.required_monthly_income(listing_params[:id])

    cookies[:required_income] = {
      value: required_income,
      expires: 24.hours.from_now
    }
    
    # Set a flash message to indicate that the modal should be shown
    flash[:show_modal] = true
    
    redirect_to listing_path(params[:id])
  end

  private
  def listing_params
    params.permit(:id)
  end
end