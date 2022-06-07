# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Company, type: :model do
  let!(:company2) {create(:company, code: "dup-check")}
  let!(:company) {build(:company) }

  let!(:company3) {create(:company, code: "del-check")}
  let!(:group) {create(:group, company_id: company3.id, name: "del-group")}
  let!(:user) {create(:user, company_id: company3.id, email:"del-mail@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}

  context 'with validations' do
    it 'check presence of code' do
      company.code = nil
      company.valid?
      expect(company.errors[:code]).to include(/can't be blank/)
    end

    it 'check code is invalid' do
      company.code = 'test_code*'
      company.valid?
      expect(company.errors[:code]).to include(/is invalid/)
    end

    it 'check code is less than or equal to 50' do
      company.code = "a"*51
      company.valid?
      expect(company.errors[:code]).to include("is too long (maximum is 50 characters)")
    end

    it 'check code is valid' do
      company.code = 'test-code1'
      expect(company.valid?).to eq true
    end

    it 'check code is duplicate' do
      company.code = 'dup-check'
      company.valid?
      expect(company.errors[:code]).to include("has already been taken")
    end

    it 'check delete a company with all its users and groups' do
      UserGroup.create(user: user, group: group)
      company_id = company3.id
      company3.destroy
      company_count = Company.where(id: company_id).count
      expect(company_count).to be 0

      group_count = Group.where(company_id: company_id).count
      expect(group_count).to be 0

      user_count = User.where(company_id: company_id).count
      expect(user_count).to be 0

      user_count = UserGroup.where(user_id: user.id, group_id: group.id).count
      expect(user_count).to be 0
    end
  end
end
