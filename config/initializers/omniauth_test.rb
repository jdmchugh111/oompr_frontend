if Rails.env.test?
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    provider: 'google_oauth2',
    uid: '123456789',
    info: {
      name: 'Test User',
      email: 'testuser@example.com'
    },
    credentials: {
      token: 'mock_token',
      refresh_token: 'mock_refresh_token',
      expires_at: Time.now + 1.week
    }
  })
end