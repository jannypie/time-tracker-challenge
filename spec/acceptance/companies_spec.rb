require 'rails_helper'
require 'rspec_api_documentation/dsl'

# TODO: This spec could use come clean up
RSpec.resource 'Company' do
  let(:auth) { "Basic #{ Base64.encode64 "#{user.email}:#{user.password}" }" }
  let(:json) { 'application/json; charset=utf-8' }
  let(:company) { Company.create! name: 'Test Company' }
  let(:id) { company.id }
  let(:user) { User.create! email: 't@est.com', password: 'testing!' }
  let(:response) do
    {
      company: {
        id: 1,
        name: name,
        address1: nil,
        address2: nil,
        address3: nil,
        city:     nil,
        state:    nil,
        zip:      nil,
        phone1:   nil,
        phone2:   nil,
        fax1:     nil,
        fax2:     nil,
        email:    nil,
        website:  nil
      }
    }
  end

  shared_examples 'response fields' do
    response_field :id,   'Internal id of the company'
    response_field :name, 'The name of the company'
    response_field :address1, ''
    response_field :address2, ''
    response_field :address3, ''
    response_field :city,     ''
    response_field :state,    ''
    response_field :zip,      ''
    response_field :phone1,   ''
    response_field :phone2,   ''
    response_field :fax1,     ''
    response_field :fax2,     ''
    response_field :email,    ''
    response_field :website,  ''
  end

  header 'Accept',        'application/json'
  header 'Content-Type',  'application/json'
  header 'Authorization', :auth

  get '/companies' do
    let!(:company) { Company.create! name: 'Stark Industries' }
    let(:companies) { [company.attributes.except(*%w(created_at updated_at))] }

    include_examples 'response fields'

    example_request 'Listing all companies' do
      explanation 'Lists all companies'

      expect(status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(JSON.parse response_body).to eq({ 'companies' => companies })
    end
  end

  post '/companies' do
    with_options scope: :company do
      parameter :name, 'Name of the company', required: true
      parameter :address1, ''
      parameter :address2, ''
      parameter :address3, ''
      parameter :city,     ''
      parameter :state,    ''
      parameter :zip,      ''
      parameter :phone1,   ''
      parameter :phone2,   ''
      parameter :fax1,     ''
      parameter :fax2,     ''
      parameter :email,    ''
      parameter :website,  ''
    end

    let(:raw_post) { params.to_json }
    let(:name) { 'Stark Industries' }

    include_examples 'response fields'

    example_request 'Creating a company' do
      explanation 'Creates a company'

      expect(response_status).to eq 201
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  get '/companies/:id' do
    let(:name) { company.name }

    include_examples 'response fields'

    example_request 'Showing a company' do
      explanation 'Returns the information about a requested company.'

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  put '/companies/:id' do
    parameter :name, 'Name of the company', required: true, scope: :company

    let(:raw_post) { params.to_json }
    let(:name) { 'A new, different company name' }

    include_examples 'response fields'

    example_request 'Updating a company' do
      explanation 'Updates the company name.'

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  delete '/companies/:id' do
    let(:response) { {}.to_json }

    example_request 'Deleting a company' do
      explanation <<-eos
        Deletes the company. This will delete all associated projects, task
        types and any time entries associated with the company's
        projects as well.
      eos

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response
    end
  end
end
