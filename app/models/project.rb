class Project < ActiveRecord::Base
  belongs_to :company, required: true, touch: true
  has_many :time_entries, dependent: :destroy
end
