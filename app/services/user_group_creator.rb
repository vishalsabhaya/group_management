# frozen_string_literal: true

class UserGroupCreator

  def initialize(params)
    @params = params
  end

  # Assign user to group for specific company
  def call
    if company.nil?
      return raise ActiveRecord::RecordNotFound
    elsif user.nil?
      return {
        json: {
          errors: {
            code: ErrorCodes::VALIDATION_ERROR_CODES[:invalid],
            message: I18n.t("E0003"),
            field: "user_id"
          }
        },
        status: 400
      }
    elsif group.nil?
      return {
        json: {
          errors: {
            code: ErrorCodes::VALIDATION_ERROR_CODES[:invalid],
            message: I18n.t("E0004"),
            field: "group_id"
          }
        },
        status: 400
      }
    else
      user_group = UserGroup.new(user: user, group: group)
      if user_group.valid?
        user_group.save!
        return {
          json: user_group
        }
      else
        # return Error with 400
        return ModelInvalidError.to_response(user_group)
      end
    end
  end

  private

  # find out company which is already register
  def company
    Company.find_by(id: @params[:company_id])
  end

  # find out user which is already register with company
  def user
    User.find_by(id: @params[:user_id], company_id: company.id)
  end

  # find out group which is already register with company
  def group
    Group.find_by(id: @params[:group_id], company_id: company.id)
  end

  def create_params
    @params.permit(:user_id, :group_id)
  end

end
