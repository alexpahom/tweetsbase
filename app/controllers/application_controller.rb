class ApplicationController < ActionController::Base
  include SessionsHelper
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :require_permission
end
