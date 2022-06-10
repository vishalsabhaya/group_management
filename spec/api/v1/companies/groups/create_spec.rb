# frozen_string_literal: true
require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
  resource 'Groups' do
    explanation 'Create Group for company'

    header 'Accept', 'application/json'
    header 'Content-type', 'application/json'
    describe 'POST group' do
      let!(:admin_user) {create(:admin_user,email:"test@gmail.com",password:'DbdDiMSO#nwi8@')}
      let!(:company2) {create(:company, code: "dup-check")}
      let!(:group) {create(:group, company_id: company2.id, name: "group1")}

      before do
        post "/api/v1/auth/login", params: {
          email:"test@gmail.com", password: "DbdDiMSO#nwi8@"
        }
        expect(response.status).to eq(200)
        @token = JSON.parse(response.body)['token']
      end

      scenario 'valid group input' do
        post "/api/v1/companies/#{company2.id}/groups", headers:{ Authorization:  @token}, params: {
          group:{ name:"group3"}
        }
        expect(response.status).to eq(200)
      end

      scenario 'Invalid company_id in url' do
        post "/api/v1/companies/#{company2.id}/groups", headers:{ Authorization:  @token}, params: {
          group:{ name:"group1"}
        }
        expect(response.status).to eq(400)
      end

    end
  end
# rubocop:enable RSpec/EmptyExampleGroup
