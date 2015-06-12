require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to belong_to(:company).touch true }
  it { is_expected.to validate_presence_of :company }
  it { is_expected.to have_many(:time_entries).dependent :destroy }
end
