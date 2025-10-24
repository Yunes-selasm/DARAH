# frozen_string_literal: true

module Errors
  extend ::ActiveSupport::Concern

  included do
    if Rails.env.dev? || Rails.env.production?
      rescue_from StandardError, with: :server_error! do |err|
        server_error!(err)
      end
    end

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid,  with: :render_validation_error
    # rescue_from ::BadRequestError do |e|
    #   render_bad_request(message: e.message)
    # end
    # rescue_from ::UnauthorizedError do |e|
    #   render_unauthorized(message: e.message)
    # end
    rescue_from ActionController::ParameterMissing do |e|
      render_bad_request(message: e.message)
    end
    # rescue_from ::ValidationFailed do |e|
    #   render_unprocessable_entity(message: e.message)
    # end
    rescue_from RailsParam::InvalidParameterError do |e|
      render_bad_request(message: e.message)
    end

    rescue_from ActionDispatch::Http::Parameters::ParseError do |e|
      render_bad_request(message: 'Invalid parameters format')
    end
    rescue_from ActiveRecord::InvalidForeignKey do |e|
      Rollbar.error(e)

      render_not_found(message: 'ForeignKeyNotFound')
    end
  end

  private

  def record_not_found
    render_not_found
  end

  def server_error!(err)
    Rollbar.error(err)

    render_bad_request(message: 'Internal server error')
  end
end

