require 'rails_helper'

RSpec.describe User, type: :model do
  # TODO: Test Devise inclusions
  it { is_expected.to have_many(:time_entries).dependent :destroy }
end
