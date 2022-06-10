# frozen_string_literal: true
require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
RSpec.describe "UserGroups", type: :request do
  resource 'UserGroups' do
    explanation 'Assign a user to group'

    header 'Accept', 'application/json'
    header 'Content-type', 'application/json'
    describe 'POST group' do

      let!(:admin_user) {create(:admin_user,email:"test@gmail.com",password:'DbdDiMSO#nwi8@')}
      let!(:company) {create(:company, code: "company1")}
      let!(:user) {create(:user, company_id: company.id, email:"user1@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}
      let!(:group) {create(:group, company_id: company.id, name:"group1")}

      before do
        post "/api/v1/auth/login", params: {
          email:"test@gmail.com", password: "DbdDiMSO#nwi8@"
        }
        expect(response.status).to eq(200)
        @token = JSON.parse(response.body)['token']
      end

      scenario 'valid user assign to group for specific company' do
        post "/api/v1/companies/#{company.id}/assign_group_user", headers:{ Authorization:  @token}, params: {
          user_id: user.id,
          group_id: group.id
        }
        expect(response.status).to eq(200)
      end

      scenario 'invalid group id' do
        post "/api/v1/companies/#{company.id}/assign_group_user", headers:{ Authorization:  @token}, params: {
          user_id: user.id,
          group_id: 100
        }
        expect(response.status).to eq(400)
      end

      scenario 'invalid user id' do
        post "/api/v1/companies/#{company.id}/assign_group_user", headers:{ Authorization:  @token}, params: {
          user_id: 100,
          group_id: group.id
        }
        expect(response.status).to eq(400)
      end

      scenario 'Invalid company_id in url' do
        post "/api/v1/companies/100/assign_group_user", headers:{ Authorization:  @token}, params: {
          user_id: user.id,
          group_id: group.id
        }
        expect(response.status).to eq(404)
      end

    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
