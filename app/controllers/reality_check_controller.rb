class RealityCheckController < ApplicationController
  def index
    city = cookies[:city]
    cookies[:monthly] = {
      value: params[:monthly],
      expires: 24.hours.from_now
    }
    monthly_income = cookies[:monthly]

    @rc_listings = fetch_reality_check(city, monthly_income)
  end

  private

  def fetch_reality_check(city, monthly_income)
    cache_key = "reality_check_#{city}_#{monthly_income}"
    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      OomprBeFacade.new.reality_check(city, monthly_income)
    end
  end
end