class ResetsController < ApplicationController
  skip_before_action :require_login
  def new; end

  def edit; end
end
