# Login: https://apis.io/auth/github (redirects to GitHub)
# Callback URL: http://apis.io/auth/github/callback
#
# For development change `apis.io` to `localhost:3000`.
#
# The environment variables need to be set. To set them locally:
#
#     export GITHUB_CLIENT_ID=<client-id>
#     export GITHUB_CLIENT_SECRET=<client-secret>
#
# To set them on Heroku:
#
#     heroku config:add GITHUB_CLIENT_ID=<client-id> GITHUB_CLIENT_SECRET=<client-secret>
#
Rails.application.config.middleware.use OmniAuth::Builder do
  envvars = {id: 'GITHUB_CLIENT_ID', secret: 'GITHUB_CLIENT_SECRET'}
  envvars.values.each do |envvar|
    raise "The #{envvar} environment variable must be set." unless ENV.has_key? envvar
  end
  provider :github, ENV[envvars[:id]], ENV[envvars[:secret]]
end
