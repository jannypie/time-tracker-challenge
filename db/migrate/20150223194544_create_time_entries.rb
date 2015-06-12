class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.belongs_to :task
      t.integer :duration
      t.datetime :started_at, default: nil
      t.timestamps null: false
    end
  end
end
