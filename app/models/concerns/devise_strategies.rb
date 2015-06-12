module DeviseStrategies
  extend ActiveSupport::Concern

  included do
    # NOTE: Comes from simple_token_authentication gem
    acts_as_token_authenticatable

    # NOTE: Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable,
           :rememberable, :trackable, :validatable
  end
end
