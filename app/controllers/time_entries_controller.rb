class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: %i(update destroy show)

  def index
    time = params[:date] ? Time.parse(params[:date]) : Time.now
    @time_entries = TimeEntry.for_date(time).for_user current_user
  end

  def create
    @time_entry = TimeEntry.new time_entry_params
    @time_entry.user = current_user
    @time_entry.save
    render status: 201
  end

  def update
    @time_entry.update_attributes time_entry_params
  end

  def destroy
    @time_entry.destroy
  end

  private

  def set_time_entry
    @time_entry = TimeEntry.for_user(current_user).find params[:id]
  end

  def time_entry_params
    params.require(:time_entry)
      .permit :duration, :project_id, :started_at, :task_id, :created_at
  end
end
