# frozen_string_literal: true
require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
RSpec.describe "Groups", type: :request do
  resource 'Groups' do
    explanation 'List Group'

    header 'Accept', 'application/json'
    header 'Content-type', 'application/json'
    describe 'GET group' do
      let!(:admin_user) {create(:admin_user,email:"test@gmail.com",password:'DbdDiMSO#nwi8@')}
      let!(:company) {create(:company, code: "Company-1")}

      before do
        6.times do |n|
          group = Group.create(company_id: company.id, name: "group-#{n}")
          15.times do |n|
            user = User.create(company_id: company.id, email:"user#{n}@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)
            UserGroup.create(user_id: user, group_id: group)
          end
        end
        @group = Group.find_by_name("group-3")
        post "/api/v1/auth/login", params: {
          email:"test@gmail.com", password: "DbdDiMSO#nwi8@"
        }
        expect(response.status).to eq(200)
        @token = JSON.parse(response.body)['token']
      end

      scenario 'list group with user count' do
        get "/api/v1/companies/#{company.id}/groups", headers:{ Authorization:  @token}
        expect(response.status).to eq(200)
      end

      scenario 'targted group with user count' do
        get "/api/v1/companies/#{company.id}/groups", headers:{ Authorization:  @token}, params: {
          group:{ page: 1 , group_id: @group.id }
        }
        expect(response.status).to eq(200)
      end

      scenario 'Invalid company_id in url' do
        get "/api/v1/companies/100/groups", headers:{ Authorization:  @token}
        expect(response.status).to eq(404)
      end

    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
