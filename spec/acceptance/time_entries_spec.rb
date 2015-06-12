require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.resource 'TimeEntries' do
  include ActiveSupport::Testing::TimeHelpers

  let(:auth) { "Basic #{ Base64.encode64 "#{user.email}:#{user.password}" }" }
  let(:json) { 'application/json; charset=utf-8' }
  let(:company) { Company.create! name: 'Test Company' }
  let(:project) { Project.create! name: 'Test Project', company: company }
  let(:project_id) { project.id }
  let(:task) { Task.create! name: 'Test Task', company: company }
  let(:task_id) { task.id }
  let(:time_entry) { project.time_entries.create! task: task, user: user }
  let(:id) { time_entry.id }
  let(:user) { User.create! email: 't@est.com', password: 'testing!' }

  shared_examples 'response fields' do
    response_field :id, 'Internal id of the time entry'
    response_field :user_id, 'ID of the user who created the time entry'
    response_field :project_id, 'ID of the project the entry belongs to'
    response_field :task_id, 'ID of the associated task'
    response_field :duration, 'The total number of seconds spent on this entry'
    response_field :started_at, 'When it was started; active if not nil'
  end

  header 'Accept',       'application/json'
  header 'Content-Type', 'application/json'
  header 'Authorization', :auth

  get '/time_entries' do
    let(:date) { 3.days.ago.strftime('%Y-%m-%d') }
    let!(:time_entry) do
      TimeEntry.create!(
        created_at: 3.days.ago,
        project: project,
        task: task,
        user: user)
    end

    let(:response) do
      {
        time_entries: [
          { 
            id: 1,
            duration: nil,
            project_id: project.id,
            started_at: nil,
            task_id: task.id,
            user_id: user.id,
          }
        ]
      }
    end

    parameter :date, 'Date param for filtering time entries YYYY-MM-DD'

    include_examples 'response fields'

    example_request 'Listing time entries' do
      explanation <<-eos
        Lists all the time entries for the currently signed in user.
        Will default to displaying time entries for the current date
        if none is provided.
      eos

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  post '/time_entries' do
    with_options scope: :time_entry do
      parameter :duration,   'The total number of seconds spent on this entry'
      parameter :project_id, 'ID of the associated project', required: true
      parameter :started_at, 'When it was started; active if not nil'
      parameter :task_id,    'ID of the associated task', required: true
    end

    let(:raw_post) { params.to_json }
    let(:duration) { nil }
    let(:started_at) { nil }
    let(:response) do
      { 
        time_entry: {
          id: 1,
          duration: nil,
          project_id: project.id,
          started_at: nil,
          task_id: task.id,
          user_id: user.id,
        }
      }
    end

    include_examples 'response fields'

    example_request 'Creating a time entry' do
      explanation <<-eos
        Creates a new time entry for the given project tagged with a type of
        task. If work has already been done for the task, the duration can be
        specified at the time of creation. Similarly, a task can be started
        when it is created by specifying the `started_at` time.

        You can use the described parameters or submit a JSON representation
        of the object.
      eos

      expect(response_status).to eq 201
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  get '/time_entries/:id' do
    let(:response) do
      {
        time_entry: {
          id: time_entry.id,
          duration: nil,
          project_id: project.id,
          started_at: nil,
          task_id: task.id,
          user_id: user.id,
        }
      }
    end

    include_examples 'response fields'

    example_request 'Showing a time entry' do
      explanation 'Returns the information about a requested time entry.'

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  put '/time_entries/:id' do
    with_options scope: :time_entry do
      parameter :duration,   'The total number of seconds spent on this entry'
      parameter :task_id,    'ID of the associated task', required: true
      parameter :started_at, 'When it was started; active if not nil'
    end

    let(:raw_post) { params.to_json }
    let(:duration) { 300 }
    let(:started_at) { Time.now.round }
    let(:response) do
      {
        time_entry: {
          id: time_entry.id,
          duration: duration,
          project_id: project.id,
          started_at: started_at.utc,
          task_id: task.id,
          user_id: user.id,
        }
      }
    end

    include_examples 'response fields'

    example_request 'Updating a time entry' do
      explanation <<-eos
        Updates the time entry. If `started_at` was previously set, and is then
        updated to be `nil`, the total duration property is updated with the
        elapsed time since the timer started. Duration can be set at the same
        time a timer is stopped.

        You can use the described parameters or submit a JSON representation
        of the object.
      eos

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response.to_json
    end
  end

  delete 'time_entries/:id' do
    let(:response) { {}.to_json }

    example_request 'Deleting a time entry' do
      explanation 'Deletes the time entry. This is a hard delete.'

      expect(response_status).to eq 200
      expect(response_headers['Content-Type']).to eq json
      expect(response_body).to eq response
    end
  end
end
