class Api::V1::GroupsController < ApplicationController

  # POST
  def create
    render GroupCreator.new(params).call
  end

end
