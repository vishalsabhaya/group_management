require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe "authentication api" do

    let!(:company2) {create(:company, code: "dup-check")}
    let!(:group) {create(:group, company_id: company2.id, name: "group1")}

    scenario 'check unauthorized' do
      post "/api/v1/companies/#{company2.id}/groups", params: {
        group:{ name:"group3"}
      }
      expect(response.status).to eq(401)
    end

  end
end
