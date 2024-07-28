class RealityCheckController < ApplicationController
  def index
    @facade = OomprBeFacade.new
    cookies[:monthly] = params[:monthly]
    @rc_listings = @facade.reality_check(cookies[:city], cookies[:monthly])
  end
end