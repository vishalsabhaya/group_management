# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Company, type: :model do
  let!(:company2) {create(:company, code: "dup-check")}
  let!(:company) {build(:company) }
  context 'with validations' do
    it 'check presence of code' do
      company.code = nil
      company.valid?
      expect(company.errors[:code]).to include(/can't be blank/)
    end

    it 'check code is invalid' do
      company.code = 'test_code*'
      company.valid?
      expect(company.errors[:code]).to include(/is invalid/)
    end

    it 'check code is less than or equal to 50' do
      company.code = "a"*51
      company.valid?
      expect(company.errors[:code]).to include("is too long (maximum is 50 characters)")
    end

    it 'check code is valid' do
      company.code = 'test-code1'
      expect(company.valid?).to eq true
    end

    it 'check code is duplicate' do
      company.code = 'dup-check'
      company.valid?
      expect(company.errors[:code]).to include("has already been taken")
    end
  end
end
