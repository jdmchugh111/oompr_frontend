class SessionsController < ApplicationController
  def create
    Rails.logger.info "WE GET HERE #{request.env["omniauth.auth"]}" 
    #inside of request.env["omniauth.auth"]["info"] we have name email 
    #inside of request.env["omniauth.auth"]["provider"] we have name of the provider 
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.valid?
      session[:user_id] = user.id
      redirect_to user_path(user)
    else 
      flash[:notice] = "Must create account first"
      User.create!(user_params)
      session[:user_id] = user.id
      redirect_to '/'

    end
  end


  def new
  end

  def destroy
    session.destroy
    redirect_to "/"
  end

  private 

  def user_params
    params.permit(:name, :email)
  end
end