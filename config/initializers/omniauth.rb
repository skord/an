Rails.application.config.middleware.use OmniAuth::Builder do
  provider :steam, ENV['STEAM_WEB_API_KEY']
  provider :slack, ENV['SLACK_API_KEY'], ENV['SLACK_API_SECRET'], scope: "identify,read,post"
end
