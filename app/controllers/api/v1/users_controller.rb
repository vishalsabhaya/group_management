class Api::V1::UsersController < ApplicationController

  # POST /api/v1/companies/:company_id/users
  def create
    render UserCreator.new(params).call
  end

end
