require 'rails_helper'

RSpec.describe Group, type: :model do
  let!(:company) {create(:company, code: "company-1")}
  let!(:company2) {create(:company, code: "company-2")}

  #it will used to identify duplicate check
  let!(:group2) {create(:group, company_id: company.id, name: "dup-check")}

  let!(:group) {build(:group, company_id: company.id) }
  let!(:group3) {build(:group, company_id: company2.id) }

  context 'with validations' do
    it 'check presence of name' do
      group.name = nil
      group.valid?
      expect(group.errors[:name]).to include(/can't be blank/)
    end

    it 'check name is less than or equal to 100' do
      group.name = "a"*101
      group.valid?
      expect(group.errors[:name]).to include("is too long (maximum is 100 characters)")
    end

    it 'check name is duplicate if company is same' do
      group.name = 'dup-check'
      group.valid?
      expect(group.errors[:name]).to include("has already been taken")
    end

    it 'check same name is not duplicate if company is different' do
      group3.name = 'dup-check1'
      expect(group3.valid?).to be true
    end
  end
end
