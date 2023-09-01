class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource_or_scope)
    Profile.create(user: current_user)
    '/top_genres/new'
  end
end
