class Api::V1::GroupsController < ApplicationController

  def create
    render GroupCreator.new(params).call
  end

  private

  def create_params
    params.require(:group).permit(:name)
  end

  def company_params
    params.permit(:company_id)
  end

end
