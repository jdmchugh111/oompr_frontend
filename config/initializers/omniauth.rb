
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.development[:google_id], Rails.application.credentials.development[:google_secret]
end
OmniAuth.config.allowed_request_methods = %i[get]
