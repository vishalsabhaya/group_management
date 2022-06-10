# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request
  # NOTE: Aside from these exceptions, error control flow should be
  # managed via conditional rendering. (e.g: Using if-else statements. NOT by raise)
  CUSTOM_API_ERRORS = {
    ActionController::ParameterMissing => ParameterMissingError,
    ActionController::UnpermittedParameters => UnpermittedParametersError,
    ActiveRecord::RecordNotFound => RecordNotFoundError
  }.freeze

  around_action :around_api_process

  private

  def around_api_process
    yield
  rescue StandardError => e
    render_error_as_json(e)
  end

  def render_error_as_json(exception)
    error = build_custom_error(exception)

    logger.error error.error_logs(exception)

    render status: error.http_status_code,
           json: { errors: error.errors_for_response }
  end

  # catch Error & return error
  def build_custom_error(exception)
    klass = CUSTOM_API_ERRORS[exception.class]

    if klass.present?
      klass.new
    else
      InternalServerError.new(request_id: request.request_id)
    end
  end

  # Authorize token & serve API output
  def authenticate_request
    header = request.headers["Authorization"]
    if header
      header = header.split(" ").last
      decoded = jwt_decode(header)
      @current_user = AdminUser.find(decoded[:user_id])
    else
      render status: :unauthorized,
             json: {error: I18n.t("E0005")}
    end
  end

end
