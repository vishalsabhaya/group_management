# frozen_string_literal: true

class GroupCreator

  def initialize(params)
    @params = params
  end

  def call
    if company.nil?
      return {
        json: {
          errors: [
            {
                "code": 404002,
                "message": "Record not found",
                "field": "company_id"
            }
        ]
        },
        status: 400
      }
    else
      group = company.groups.new(create_params)
      if group.valid?
        group.save!
        return {
          json: group
        }
      else
        return ModelInvalidError.to_response(group)
      end
    end
  end

  private

  def company
    Company.find_by(id: @params[:company_id])
  end

  def create_params
    @params.require(:group).permit(:name)
  end

end
