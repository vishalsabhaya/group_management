class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  #POST /v1/auth/login
  def login
    @admin_user = AdminUser.find_by_email(params[:email])
    if @admin_user&.authenticate(params[:password])
      token = jwt_encode(user_id: @admin_user.id)
      render json: {token: token}, status: :ok
    else
      render json: {error: I18n.t("E0005")}, status: :unauthorized
    end
  end

end
