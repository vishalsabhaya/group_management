require 'rails_helper'

RSpec.describe Group, type: :model do
  let!(:company) {create(:company, code: "company-1")}

  #it will used to identify duplicate check
  let!(:group) {create(:group, company_id: company.id, name: "group1")}
  let!(:user) {create(:user, company_id: company.id, email:"user1@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}

  context 'with validations' do
    it 'allow to assign user to group' do
      user_group = UserGroup.new(user: user, group: group)
      expect(user_group.valid?).to be true
    end
  end

end
