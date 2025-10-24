class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  
  allow_browser versions: :modern

  skip_before_action :require_authentication, only: :server_status

  def server_status
    render(
      json: {
        success: true,
        message: 'API Server is up',
        env: 'dev'
      }
    )
  end
end
