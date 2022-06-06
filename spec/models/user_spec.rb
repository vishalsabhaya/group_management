require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:company) {create(:company, code: "company-1")}
  let!(:company2) {create(:company, code: "company-2")}
  let!(:company3) {create(:company, code: "company-3")}

  #it will used to identify duplicate check
  let!(:user2) {create(:user, company_id: company.id, email:"dup-check@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}

  let!(:user) {build(:user, company_id: company.id) }
  let!(:user3) {build(:user, company_id: company2.id) }

  #user 1
  let!(:user11) {create(:user, company_id: company3.id, email:"user1@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18) }
  let!(:user12) {create(:user, company_id: company3.id, email:"user2@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18) }
  let!(:user13) {create(:user, company_id: company3.id, email:"user3@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18) }
  let!(:user14) {create(:user, company_id: company3.id, email:"user4@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18) }
  let!(:user15) {create(:user, company_id: company3.id, email:"user5@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18) }
  let!(:user16) {create(:user, company_id: company3.id, email:"user6@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18) }
  let!(:user17) {create(:user, company_id: company3.id, email:"user7@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18) }
  let!(:user18) {create(:user, company_id: company3.id, email:"user8@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18) }
  let!(:user19) {create(:user, company_id: company3.id, email:"user9@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18) }
  let!(:user20) {create(:user, company_id: company3.id, email:"user10@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18) }
  let!(:user21) {build(:user, company_id: company3.id) }

  context 'with validations' do
    it 'check presence of email' do
      user.assign_attributes({email:"", first_name:"GMO", last_name:"JAPAN", age: 40})
      user.valid?
      expect(user.errors[:email]).to include(/can't be blank/)
    end

    it 'check presence of first_name' do
      user.assign_attributes({email:"v2@gmail.com", first_name:"", last_name:"JAPAN", age: 41})
      user.valid?
      expect(user.errors[:first_name]).to include(/can't be blank/)
    end

    it 'check presence of last_name' do
      user.assign_attributes({email:"v2@gmail.com", first_name:"GMO", last_name:"", age: 45})
      user.valid?
      expect(user.errors[:last_name]).to include(/can't be blank/)
    end

    it 'check invalid age' do
      user.assign_attributes({email:"v2@gmail.com", first_name:"GMO", last_name:"", age: 17})
      user.valid?
      expect(user.errors[:age]).to include(/You should be over 18 years old./)
    end

    it 'check invalid first_name if length > 50' do
      user.assign_attributes({email:"v2@gmail.com", first_name:"a"*51, last_name:"JAPAN", age: 20})
      user.valid?
      expect(user.errors[:first_name]).to include("is too long (maximum is 50 characters)")
    end

    it 'check invalid last_name if length > 50' do
      user.assign_attributes({email:"v2@gmail.com", first_name:"GMO", last_name:"a"*51, age: 26})
      user.valid?
      expect(user.errors[:last_name]).to include("is too long (maximum is 50 characters)")
    end

    it 'check email is duplicate if email is same within company' do
      user.assign_attributes({email:"dup-check@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 29})
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'check same email is not duplicate if company is different' do
      user3.assign_attributes({email:"dup-check@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 35})
      expect(user3.valid?).to be true
    end

    it 'check Exceeded user limit if try to register 11th user' do
      user21.assign_attributes({email:"user11@gmail.com", first_name:"GMO", last_name:"JAPAN", age: 30})
      user21.valid?
      expect(user21.errors[:user_limit]).to include("Exceeded user limit")
    end

  end
end
