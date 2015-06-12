require 'rails_helper'

RSpec.describe TimeEntry, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  let(:company) { Company.create! name: 'Test Company' }
  let(:project) { company.projects.create! name: 'Test Project' }
  let(:task) { company.tasks.create! name: 'Test Task' }
  let(:user) { User.create! email: 'user@test.com', password: 'testing!' }

  it { is_expected.to belong_to(:project).touch true }
  it { is_expected.to belong_to :task }
  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :project }
  it { is_expected.to validate_presence_of :task }
  it { is_expected.to validate_presence_of :user }

  describe '.for_user' do
    let(:bob) { User.create! email: 'bob@test.com', password: 'testing!' }
    let(:jim) { User.create! email: 'jim@test.com', password: 'testing!' }
    let(:bob_entry) { bob.time_entries.create! task: task, project: project }
    let(:jim_entry) { jim.time_entries.create! task: task, project: project }

    it 'returns only time entries for the specified user' do
      expect(TimeEntry.for_user jim).to include jim_entry
      expect(TimeEntry.for_user jim).not_to include bob_entry
    end

    it 'returns nothing if no user is specified' do
      expect(TimeEntry.for_user nil).to be_empty
    end
  end

  describe '.running' do
    let(:attrs) { { task: task, project: project, started_at: 2.days.ago } }
    let(:started) { user.time_entries.create! attrs }
    let(:stopped) { user.time_entries.create! attrs.merge started_at: nil }

    it 'returns only time entries that are started' do
      expect(TimeEntry.running).to include started
      expect(TimeEntry.running).not_to include stopped
    end
  end

  context 'when a time entry is started' do
    let(:attrs) { { task: task, project: project, started_at: time } }
    let(:elapsed_seconds) { rand 50 }
    let(:time) { Time.at 140_000_000_0 }
    let(:time_entry) { user.time_entries.create! attrs }

    context 'and it is changed to a stopping state' do
      before do
        travel_to time + elapsed_seconds
        time_entry.update_attributes started_at: nil
        travel_back
      end

      it 'add the elapsed time to the duration' do
        expect(time_entry.duration).to eq elapsed_seconds
      end
    end
  end
end
