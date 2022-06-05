# frozen_string_literal: true
require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
  resource 'Companies' do
    explanation 'Create Company'

    header 'Accept', 'application/json'
    header 'Content-type', 'application/json'

    post '/api/v1/companies' do
      with_options company: :company do
        parameter :code, 'uniq code for company', type: :string, required: true
      end

      context 'with 200 status' do
        let(:code) { 'text-code' }

        example_request 'Creating a company' do
          expect(status).to eq(200)
        end
      end

      context 'with 400 status' do
        let(:code) { 'test***' }

        example_request 'Creating a company - errors' do
          json = JSON.parse(response_body)

          expect(status).to eq(400)
          expect(json['errors']).to include({
                                              'code' => 400024, 'message' => "is invalid", 'field' => 'code'
                                            })
        end
      end
    end
  end
# rubocop:enable RSpec/EmptyExampleGroup
