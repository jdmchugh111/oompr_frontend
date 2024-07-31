class FavoritesController < ApplicationController
  def create
    if current_user.present? && params[:favorite] == "true"
      user_id = current_user.id.to_s
      listing_id = params[:id]

      service = OomprBeService.new
      service.new_favorite(user_id, listing_id)
    else
      redirect_to '/auth/google_oauth2'
    end
  end

  def destroy
  end
end