class TimeEntry < ActiveRecord::Base
  with_options required: true do
    belongs_to :project, touch: true
    belongs_to :task
    belongs_to :user
  end

  before_save :compute_duration,  if: :stopping?
  after_save :stop_other_entries, if: :starting?

  scope :running, -> { where.not started_at: nil }
  scope :for_user, -> (user = nil) { where user: user }

  # TODO: Spec and cop this
  scope :for_date, -> (date = Time.current) do
    where created_at: date.at_beginning_of_day .. date.at_end_of_day
  end

  private

  def starting?
    started_at_changed? from: nil
  end

  def stopping?
    started_at_changed? to: nil
  end

  def stop_other_entries
    # NOTE: Should we stop other time entries from running?
    # user.time_entries.running.each { update_attributes started_at: nil }
  end

  def compute_duration
    self.duration = (Time.now - started_at_was + duration.to_i).to_i
  end
end
