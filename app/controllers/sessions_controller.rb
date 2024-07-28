class SessionsController < ApplicationController
  def create
    Rails.logger.info "we get here #{request.env["omniauth.auth"]["info"]}" 
    #inside of request.env["omniauth.auth"]["info"] we have name email 
    #indise of #{request.env["omniauth.auth"]["provider"]} we have the google oauth 2 or the providers 

    #this is where i would find or create a user 
  end


  # def new
  #   audience = auth_client_id
  #   claim = verify_oidc(audience)

  #   if claim
  #     new_session(claim)
  #     redirect_to "/dashboard"
  #   else
  #     logger.info("No valid identity token present")
  #     401
  #   end
  # end

  # def destroy
  #   session.clear
  #   redirect_to "/"
  # end

  private 

  def user_params
    params.permit()
  end

  # def auth_client_id
  #   Google::Auth::ClientId.new(
  #     Rails.application.credentials.google[:client_id],
  #     Rails.application.credentials.google[:client_secret]
  #   ).id
  # end

  # def verify_oidc(audience)
  #   Google::Auth::IDTokens.verify_oidc(
  #     params["credential"],
  #     aud: audience,
  #     azp: audience
  #   )
  # end

  # def new_session(claim)
  #   User.find_or_create_by(
  #     user_id: claim["sub"],
  #     name: claim["name"]
  #   )
  #   session[:user_name] = claim["name"]
  #   session[:user_id] = claim["sub"]
  # end
end