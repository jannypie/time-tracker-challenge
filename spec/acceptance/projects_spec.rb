require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource 'Project' do
  let(:auth) { "Basic #{ Base64.encode64 "#{user.email}:#{user.password}" }" }
  let(:json) { 'application/json; charset=utf-8' }
  let(:company) { Company.create! name: 'Test Company' }
  let(:company_id) { company.id }
  let(:project) { company.projects.create! name: 'Test Project' }
  let(:id) { project.id }
  let(:user) { User.create! email: 't@est.com', password: 'testing!' }

  shared_examples 'response fields' do
    response_field :id,         'Internal id of the project'
    response_field :company_id, 'ID of the company this prject belongs to'
    response_field :name,       'The name of the project'
  end

  header 'Accept',        'application/json'
  header 'Content-Type',  'application/json'
  header 'Authorization', :auth

  get '/companies/:company_id/projects' do
    let!(:project) { company.projects.create! name: 'Test project' }
    let(:response) do
      { projects: [{ id: 1, name: project.name, company_id: company.id }] }
    end

    include_examples 'response fields'

    example_request 'Listing projects from a company' do
      explanation 'Lists all the project for a given company'

      expect(status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  post '/companies/:company_id/projects' do
    parameter :name, 'Name the project', required: true, scope: :project

    let(:raw_post) { params.to_json }
    let(:name) { 'Test project name' }
    let(:response) do
      { project: { id: 1, name: name, company_id: company.id } }
    end

    include_examples 'response fields'

    example_request 'Creating a project' do
      explanation 'Creates a new project for a company'

      expect(response_status).to eq 201
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  get '/companies/:company_id/projects/:id' do
    let(:response) do
      { project: { id: 1, name: project.name, company_id: company.id } }
    end

    include_examples 'response fields'

    example_request 'Showing a project' do
      explanation 'Returns the information about a requested project.'

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  put '/companies/:company_id/projects/:id' do
    parameter :name, 'Name the project', required: true, scope: :project

    let(:raw_post) { params.to_json }
    let(:name) { 'A new, different name' }
    let(:response) do
      { project: { id: 1, name: name, company_id: company.id } }
    end

    include_examples 'response fields'

    example_request 'Updating a project' do
      explanation 'Updates the project name.'

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  delete '/companies/:company_id/projects/:id' do
    let(:response) { {}.to_json }

    example_request 'Deleting a project' do
      explanation <<-eos
        Deletes the project. This will delete all associated time entries
        associated with the project as well.
      eos

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response
    end
  end
end
