class Api::V1::GroupsController < ApplicationController
  include Pagy::Backend
  DEFAULT_PAGE = 1
  # list out group information with user count
  def index
    if company.nil?
      render raise ActiveRecord::RecordNotFound
    else
      group_list = company.groups
                          .joins(:users)
                          .group(:id, :name)
                          .select(" groups.id AS group_id,
                                    groups.name AS group_name,
                                    COUNT(*) AS user_count")
      # group_id is optional parameter. if present then filter by group_id
      group_list = group_list.where(id: params[:group_id]) if params[:group_id].present?
      pagy, group_list = pagy(group_list, page: page).as_json(:except => :id)

      render json: {
          rows: group_list,
          page: pagy["page"],
          total_rows: pagy["count"]
        }

    end
  end

  # POST
  def create
    render GroupCreator.new(params).call
  end

  private

  # find out company which is already register
  def company
    Company.find_by(id: params[:company_id])
  end

  def page
    params[:page] || DEFAULT_PAGE
  end

end
