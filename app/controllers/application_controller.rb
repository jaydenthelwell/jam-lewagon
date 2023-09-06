class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
    users_path
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :date_of_birth, :location, :gender, :on_repeat, :all_time_favorite, :go_to_karaoke, :description, photos: []])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :date_of_birth, :location, :gender, :on_repeat, :all_time_favorite, :go_to_karaoke, :description, photos: []])
  end

  # def after_sign_in_path_for(resource_or_scope)
  #   Profile.create(user: current_user)
  #   '/top_genres/new'
  # end

end
