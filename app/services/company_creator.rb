# frozen_string_literal: true

class CompanyCreator

  def initialize(params)
    @params = params
  end

  # Register company
  def call
    company = Company.new(create_params)
    if company.valid?
      company.save!
      return {
        json: company
      }
    else
      return ModelInvalidError.to_response(company)
    end
  end

  private

  # filter authentic data
  def create_params
    @params.require(:company).permit(:code)
  end

end
