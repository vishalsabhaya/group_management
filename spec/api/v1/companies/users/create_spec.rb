# frozen_string_literal: true
require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
RSpec.describe "Users", type: :request do
  resource 'Users' do
    explanation 'Create Group for company'

    header 'Accept', 'application/json'
    header 'Content-type', 'application/json'
    describe 'POST group' do

      let!(:admin_user) {create(:admin_user,email:"test@gmail.com",password:'DbdDiMSO#nwi8@')}
      let!(:company) {create(:company, code: "company1")}
      let!(:user) {create(:user, company_id: company.id, email:"user1@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}

      before do
        post "/api/v1/auth/login", params: {
          email:"test@gmail.com", password: "DbdDiMSO#nwi8@"
        }
        expect(response.status).to eq(200)
        @token = JSON.parse(response.body)['token']
      end

      scenario 'valid user input' do
        post "/api/v1/companies/#{company.id}/users", headers:{ Authorization:  @token}, params: {
          user:{ email:"user2@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18}
        }
        expect(response.status).to eq(200)
      end

      scenario 'Invalid company_id in url' do
        post "/api/v1/companies/#{company.id}/users", headers:{ Authorization:  @token}, params: {
          user:{ email:"user1@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18}
        }
        expect(response.status).to eq(400)
      end

      scenario 'Invalid company_id in url' do
        post "/api/v1/companies/11/users", headers:{ Authorization:  @token}, params: {
          user:{ email:"user1@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18}
        }
        expect(response.status).to eq(404)
      end

    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
