# frozen_string_literal: true
require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
  resource 'Groups' do
    explanation 'Create Group for company'

    header 'Accept', 'application/json'
    header 'Content-type', 'application/json'
    describe 'POST group' do
      let!(:company2) {create(:company, code: "dup-check")}
      let!(:group) {create(:group, company_id: company2.id, name: "group1")}
      scenario 'valid group input' do
        post "/api/v1/companies/#{company2.id}/groups", params: {
          group:{ name:"group3"}
        }
        expect(response.status).to eq(200)
      end
      scenario 'Invalid company is in url' do
        post "/api/v1/companies/#{company2.id}/groups", params: {
          group:{ name:"group1"}
        }
        expect(response.status).to eq(400)
      end
    end
  end
# rubocop:enable RSpec/EmptyExampleGroup
