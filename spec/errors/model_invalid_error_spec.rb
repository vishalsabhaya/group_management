# frozen_string_literal: true

describe ModelInvalidError do
  let(:company) { build(:company, code: 'a*') }
  let(:error) { described_class.new(model: company) }

  before do
    company.valid?
  end

  describe '.to_response' do
    it 'returns a hash formatted to render as JSON' do
      expect(described_class.to_response(company)).to eq({ json: { errors: [{ code: 400024,
                                                                            field: 'code',
                                                                            message: 'is invalid' }] },
                                                         status: 400 })
    end
  end

  describe '#http_status_code' do
    it 'returns a 400 status' do
      expect(error.http_status_code).to eq(400)
    end
  end

  describe '#errors_for_response' do
    it 'returns an array of model validation error' do
      expect(error.errors_for_response).to include({
                                                     code: 400024,
                                                     field: 'code',
                                                     message: 'is invalid'
                                                   })
    end

  end
end
