# frozen_string_literal: true
require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
  resource 'Users' do
    explanation 'Create Group for company'

    header 'Accept', 'application/json'
    header 'Content-type', 'application/json'
    describe 'POST group' do

      let!(:company) {create(:company, code: "company1")}
      let!(:user) {create(:user, company_id: company.id, email:"user1@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}

      scenario 'valid user input' do
        post "/api/v1/companies/#{company.id}/users", params: {
          user:{ email:"user2@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18}
        }
        expect(response.status).to eq(200)
      end

      scenario 'Invalid company_id in url' do
        post "/api/v1/companies/#{company.id}/users", params: {
          user:{ email:"user1@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18}
        }
        expect(response.status).to eq(400)
      end

      scenario 'Invalid company_id in url' do
        post "/api/v1/companies/11/users", params: {
          user:{ email:"user1@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18}
        }
        expect(response.status).to eq(404)
      end

    end
  end
# rubocop:enable RSpec/EmptyExampleGroup
