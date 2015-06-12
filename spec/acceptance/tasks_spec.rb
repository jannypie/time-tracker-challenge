require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource 'Task' do
  let(:auth) { "Basic #{ Base64.encode64 "#{user.email}:#{user.password}" }" }
  let(:json) { 'application/json; charset=utf-8' }
  let(:company) { Company.create! name: 'Test Company' }
  let(:company_id) { company.id }
  let(:task) { company.tasks.create! name: 'Test task' }
  let(:id) { task.id }
  let(:user) { User.create! email: 't@est.com', password: 'testing!' }

  shared_examples 'response fields' do
    response_field :id,         'Internal id of the task'
    response_field :company_id, 'ID of the company this task belongs to'
    response_field :name,       'The name of the task'
  end

  header 'Accept',        'application/json'
  header 'Content-Type',  'application/json'
  header 'Authorization', :auth

  get '/companies/:company_id/tasks' do
    let!(:task) { company.tasks.create! name: 'Development' }
    let(:response) do
      { tasks: [{ id: 1, name: task.name, company_id: company.id }] }
    end

    include_examples 'response fields'

    example_request 'Listing tasks from a company' do
      explanation 'Lists all of the tasks for a given company'

      expect(status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  post '/companies/:company_id/tasks' do
    parameter :name, 'Name of the task', required: true, scope: :task

    let(:raw_post) { params.to_json }
    let(:name) { task.name }
    let(:response) do
      { task: { id: Task.last.id, name: name,  company_id: company.id } }
    end

    include_examples 'response fields'

    example_request 'Creating a task' do
      explanation 'Creates a new task for a company'

      expect(response_status).to eq 201
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  get '/companies/:company_id/tasks/:id' do
    let(:response) do
      { task: { id: id, name: task.name, company_id: company.id } }
    end

    include_examples 'response fields'

    example_request 'Showing a task' do
      explanation 'Returns the information about a requested task.'

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  put '/companies/:company_id/tasks/:id' do
    parameter :name, 'Name of the task', required: true, scope: :task

    let(:raw_post) { params.to_json }
    let(:name) { 'A new, different name' }
    let(:response) do
      { task: { id: id, name: name, company_id: company.id } }
    end

    include_examples 'response fields'

    example_request 'Updating a task' do
      explanation 'Updates the task name.'

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  delete '/companies/:company_id/tasks/:id' do
    let(:response) { {}.to_json }

    example_request 'Deleting a task' do
      explanation <<-eos
        Deletes the task. This will delete all associated time entries
        associated with the task as well.
      eos

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response
    end
  end
end
