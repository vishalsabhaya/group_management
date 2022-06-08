# frozen_string_literal: true
require 'pagy'
class GroupList
  include Pagy::Backend

  def initialize(params)
    @params = params
  end

  # Register group for specific company
  def call
    if company.nil?
      return raise ActiveRecord::RecordNotFound
    else
      pagy, group_list = pagy(company.groups
                          .joins(:users)
                          .group(:id, :name)
                          .select(" groups.id AS group_id,
                                    groups.name AS group_name,
                                    COUNT(*) AS user_count")
                          .as_json(:except => :id), items: 10)
      return {
        json: group_list
      }
    end
  end

  private

  # find out company which is already register
  def company
    Company.find_by(id: @params[:company_id])
  end

end
