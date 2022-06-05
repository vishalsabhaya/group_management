class Api::V1::CompaniesController < ApplicationController

  def create
    company = Company.new(create_params)
    if company.valid?
      company.save!
    else
      render ModelInvalidError.to_response(company)
    end
  end

  private

  def create_params
    params.require(:company).permit(:code)
  end

end
