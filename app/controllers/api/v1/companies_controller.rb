class Api::V1::CompaniesController < ApplicationController

  # POST /api/v1/companies
  def create
    render CompanyCreator.new(params).call
  end

  # Assign user to group for specific company
  # POST /api/v1/companies/:company_id/assign_group_user
  def assign_group_user
    render UserGroupCreator.new(params).call
  end

  # DELETE /api/v1/companies/:id
  def destroy
    render CompanyDeletor.new(params).call
  end

end
