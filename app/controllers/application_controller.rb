class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(user)
    users_path(user)
  end
end
