Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, Rails.application.secrets.github_client_id, Rails.application.secrets.github_client_secret, scope: 'user:email'
end
