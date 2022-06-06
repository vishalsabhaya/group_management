# frozen_string_literal: true

class UserCreator

  def initialize(params)
    @params = params
  end

  # Register user for specific company
  def call
    if company.nil?
      #return error if company not register yet
      return raise ActiveRecord::RecordNotFound
    else
      user = company.users.new(create_params)
      if user.valid?
        user.save!
        return {
          json: user
        }
      else
        # return Error with 400
        return ModelInvalidError.to_response(user)
      end
    end
  end

  private

  # find out company which is already register
  def company
    Company.find_by(id: @params[:company_id])
  end

  def create_params
    @params.require(:user).permit(:email, :first_name, :last_name, :age, :company_id)
  end

end
