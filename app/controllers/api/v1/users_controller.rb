class Api::V1::UsersController < ApplicationController

  # POST
  def create
    render UserCreator.new(params).call
  end

end
