class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # サインイン後の遷移
  def after_sign_in_path_for(resource)
    user_path(@user.id)
  end
  # サインアウト後の遷移
  # これいらないかも
  def after_sign_out_path_for(resource)
    root_path
  end
  
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
