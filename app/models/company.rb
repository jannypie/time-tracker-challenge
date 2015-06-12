class Company < ActiveRecord::Base
  with_options dependent: :destroy do
    has_many :projects
    has_many :tasks
  end
end
