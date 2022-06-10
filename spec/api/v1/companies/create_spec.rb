# frozen_string_literal: true
require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
RSpec.describe "Companies", type: :request do
  resource 'Companies' do
    explanation 'Create a company using code'

    header 'Accept', 'application/json'
    header 'Content-type', 'application/json'
    describe 'POST group' do
      let!(:admin_user) {create(:admin_user,email:"test@gmail.com",password:'DbdDiMSO#nwi8@')}

      before do
        post "/api/v1/auth/login", params: {
          email:"test@gmail.com", password: "DbdDiMSO#nwi8@"
        }
        expect(response.status).to eq(200)
        @token = JSON.parse(response.body)['token']
      end

      scenario 'valid Company input' do
        post "/api/v1/companies", headers:{ Authorization:  @token}, params: {
          company:{ code:"text-code"}
        }
        expect(response.status).to eq(200)
      end

      scenario 'Creating a company - errors' do
        post "/api/v1/companies", headers:{ Authorization:  @token}, params: {
          company:{ code:"test***"}
        }
        expect(response.status).to eq(400)
      end

    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
