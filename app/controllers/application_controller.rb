class ApplicationController < ActionController::Base
  # NOTE: Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # NOTE: simple_token_authentication gem handler
  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  # NOTE: Entire app requires auth
  before_action :authenticate_user!
end
