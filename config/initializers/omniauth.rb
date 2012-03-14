Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '6606ca9f6a7be1dc45b6', '9b663eea83e4fc1e434c95bd2a4c874ce5a9f9c8'
end


# /auth/github
# http://apis.io/auth/github/callback