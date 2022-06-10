# frozen_string_literal: true
require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup

RSpec.describe "Companies", type: :request do
  resource 'Companies' do
    explanation 'Delete Company'

    header 'Accept', 'application/json'
    header 'Content-type', 'application/json'
    describe 'DELETE group' do

      let!(:admin_user) {create(:admin_user,email:"test@gmail.com",password:'DbdDiMSO#nwi8@')}
      let!(:company) {create(:company, code: "del-company")}
      let!(:group) {create(:group, company_id: company.id, name: "del-group")}
      let!(:user) {create(:user, company_id: company.id, email:"del-mail@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}

      before do
        post "/api/v1/auth/login", params: {
          email:"test@gmail.com", password: "DbdDiMSO#nwi8@"
        }
        expect(response.status).to eq(200)
        @token = JSON.parse(response.body)['token']
      end

      scenario 'delete company' do
        delete "/api/v1/companies/#{company.id}/", headers:{ Authorization:  @token}
        expect(response.status).to eq(200)
      end


      scenario 'Invalid company_id in url' do
        delete "/api/v1/companies/11/", headers:{ Authorization:  @token}
        expect(response.status).to eq(404)
      end

    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
