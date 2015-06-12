class User < ActiveRecord::Base
  include DeviseStrategies

  has_many :time_entries, dependent: :destroy
end
