class UsersController < ApplicationController
  def show
    @favorites = []
    # @favorites = fetch_favorites_for_user(current_user.id)
  end

  # private

  # def fetch_favorites_for_user(current_user.id)
  #   cache_key = "get_all_favorites_for_user_#{current_user.id}"
  #   Rails.cache.fetch(cache_key, expires_in: 12.hours) do
  #     OomprBeFacade.new.get_all_favorites_for_user(current_user.id)
  #   end
  # end
end