class ListingsController < ApplicationController
  def show
    @listing = fetch_listing(listing_params[:id])
  end

  def reality_check
    cookies[:monthly] = {
      value: params[:monthly],
      expires: 24.hours.from_now
    }

    required_income = fetch_required_income(listing_params[:id])

    cookies[:required_income] = {
      value: required_income,
      expires: 24.hours.from_now
    }
    
    # Set a flash message to indicate that the modal should be shown
    flash[:show_modal] = true
    
    redirect_to listing_path(params[:id])
  end

  private

  def fetch_listing(listing_id)
    cache_key = "listing_#{listing_id}"
    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      OomprBeFacade.new.get_listing_by_id(listing_id)
    end
  end

  def fetch_required_income(listing_id)
    cache_key = "required_income_#{listing_id}"
    Rails.cache.fetch(cache_key, expires_in: 24.hours) do
      OomprBeFacade.new.required_monthly_income(listing_id)
    end
  end

  def listing_params
    params.permit(:id)
  end
end