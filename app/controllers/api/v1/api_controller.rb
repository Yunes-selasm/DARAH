module Api::V1
  class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_request
    skip_before_action :require_authentication

    include ErrorHandlers
    include ActionParamsValidator
    include Errors

    def authenticate_request
      return if AppConfig.api_accessor.eql?(api_accessor)

      render_unauthorized(message: 'Not authorized')
    end

    def api_accessor
      request.headers['API-ACCESS-KEY']
    end
  end
end