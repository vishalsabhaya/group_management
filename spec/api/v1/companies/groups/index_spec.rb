# frozen_string_literal: true
require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
  resource 'Groups' do
    explanation 'List Group'

    header 'Accept', 'application/json'
    header 'Content-type', 'application/json'
    describe 'GET group' do

      let!(:company) {create(:company, code: "Company-1")}
      let!(:group) {create(:group, company_id: company.id, name: "group1")}
      let!(:group2) {create(:group, company_id: company.id, name: "group2")}
      let!(:group3) {create(:group, company_id: company.id, name: "group3")}
      let!(:group4) {create(:group, company_id: company.id, name: "group4")}
      let!(:group5) {create(:group, company_id: company.id, name: "group5")}
      let!(:group6) {create(:group, company_id: company.id, name: "group6")}
      let!(:group7) {create(:group, company_id: company.id, name: "group7")}
      let!(:group8) {create(:group, company_id: company.id, name: "group8")}
      let!(:group9) {create(:group, company_id: company.id, name: "group9")}
      let!(:group10) {create(:group, company_id: company.id, name: "group10")}
      let!(:group11) {create(:group, company_id: company.id, name: "group11")}
      let!(:group12) {create(:group, company_id: company.id, name: "group12")}
      let!(:group13) {create(:group, company_id: company.id, name: "group13")}
      let!(:group14) {create(:group, company_id: company.id, name: "group14")}
      let!(:group15) {create(:group, company_id: company.id, name: "group15")}
      let!(:user) {create(:user, company_id: company.id, email:"user1@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}
      let!(:user2) {create(:user, company_id: company.id, email:"user2@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}
      let!(:user3) {create(:user, company_id: company.id, email:"user3@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}
      let!(:user4) {create(:user, company_id: company.id, email:"user4@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}
      let!(:user5) {create(:user, company_id: company.id, email:"user5@gmo.com", first_name:"GMO", last_name:"JAPAN", age: 18)}

      let!(:usergroup) {UserGroup.create(user: user, group: group)}
      let!(:usergroup3) {UserGroup.create(user: user2, group: group)}
      let!(:usergroup4) {UserGroup.create(user: user3, group: group)}
      let!(:usergroup5) {UserGroup.create(user: user4, group: group)}
      let!(:usergroup6) {UserGroup.create(user: user5, group: group)}
      let!(:usergroup2) {UserGroup.create(user: user, group: group5)}
      let!(:usergroup7) {UserGroup.create(user: user, group: group2)}
      let!(:usergroup8) {UserGroup.create(user: user, group: group3)}
      let!(:usergroup9) {UserGroup.create(user: user, group: group4)}
      let!(:usergroup10) {UserGroup.create(user: user2, group: group5)}
      let!(:usergroup11) {UserGroup.create(user: user, group: group6)}
      let!(:usergroup12) {UserGroup.create(user: user, group: group7)}
      let!(:usergroup13) {UserGroup.create(user: user, group: group8)}
      let!(:usergroup14) {UserGroup.create(user: user, group: group9)}
      let!(:usergroup15) {UserGroup.create(user: user, group: group10)}
      let!(:usergroup16) {UserGroup.create(user: user, group: group11)}
      let!(:usergroup17) {UserGroup.create(user: user, group: group12)}
      let!(:usergroup18) {UserGroup.create(user: user, group: group13)}
      let!(:usergroup19) {UserGroup.create(user: user, group: group14)}
      let!(:usergroup20) {UserGroup.create(user: user, group: group15)}

      scenario 'list group with user count' do
        get "/api/v1/companies/#{company.id}/groups"
        expect(response.status).to eq(200)
      end

      scenario 'targted group with user count' do
        get "/api/v1/companies/#{company.id}/groups", params: {
          group:{ page: 1 , group_id: group7.id }
        }
        expect(response.status).to eq(200)
      end

      scenario 'Invalid company_id in url' do
        get "/api/v1/companies/100/groups"
        expect(response.status).to eq(404)
      end

    end
  end
# rubocop:enable RSpec/EmptyExampleGroup
