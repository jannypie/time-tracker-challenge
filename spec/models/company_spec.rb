require 'rails_helper'

RSpec.describe Company, type: :model do
  it { is_expected.to have_many(:projects).dependent :destroy }
  it { is_expected.to have_many(:tasks).dependent :destroy }
end
