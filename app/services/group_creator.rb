# frozen_string_literal: true

class GroupCreator

  def initialize(params)
    @params = params
  end

  # Register group for specific company
  def call
    if company.nil?
      return raise ActiveRecord::RecordNotFound
    else
      group = company.groups.new(create_params)
      if group.valid?
        group.save!
        return {
          json: group
        }
      else
        # return Error with 400
        return ModelInvalidError.to_response(group)
      end
    end
  end

  private

  # find out company which is already register
  def company
    Company.find_by(id: @params[:company_id])
  end

  def create_params
    @params.require(:group).permit(:name)
  end

end
