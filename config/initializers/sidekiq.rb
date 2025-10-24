# # frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

# # Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use Rails.application.config.session_store, Rails.application.config.session_options

Sidekiq.configure_server do |config|
  config.redis = {
    url: Rails.application.credentials[:redis_endpoint]
    # namespace: Rails.application.credentials[:redis_sidekiq_namespace] || "shift-sidekiq-#{Rails.env}"
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: Rails.application.credentials[:redis_endpoint]
    # namespace: Rails.application.credentials[:redis_sidekiq_namespace] || "shift-sidekiq-#{Rails.env}"
  }
end

# # Sidekiq logging
Sidekiq.logger.level = Logger::ERROR

# Rails.application.configure do |config|
#   Sidekiq.logger = ActiveSupport::Logger.new(config.paths['log'].first, 1, 50.megabyte)
# end

# # Sidekiq web auth
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  sq_username = ::Digest::SHA256.hexdigest(Rails.application.credentials[:sidekiq_username])
  sq_password = ::Digest::SHA256.hexdigest(Rails.application.credentials[:sidekiq_password])

  ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), sq_username) &
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), sq_password)
end
