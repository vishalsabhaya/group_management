class Api::V1::CompaniesController < ApplicationController

  # POST
  def create
    render CompanyCreator.new(params).call
  end

  # Assign user to group for specific company
  def assign_group_user
    render UserGroupCreator.new(params).call
  end

  # delete
  def destroy
    render CompanyDeletor.new(params).call
  end

end
