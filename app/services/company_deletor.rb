# frozen_string_literal: true

class CompanyDeletor

  def initialize(params)
    @params = params
  end

  # Delete company
  def call
    if company.nil?
      return raise ActiveRecord::RecordNotFound
    else
      ret_obj = company.destroy
      return {
        json: ret_obj
      }
    end
  end

  private

  # find out company which is already register
  def company
    Company.find_by(id: @params[:id])
  end



end
