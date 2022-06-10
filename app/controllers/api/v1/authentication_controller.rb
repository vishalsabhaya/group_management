class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  #POST /api/v1/auth/login
  def login
    @admin_user = AdminUser.find_by_email(params[:email])
    if @admin_user&.authenticate(params[:password])
      token = jwt_encode(user_id: @admin_user.id)
      render json: {token: token}, status: :ok
    else
      render status: :unauthorized,
             json: {error: I18n.t("E0005")}
    end
  end

end
