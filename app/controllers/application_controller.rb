class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # ログインしてない場合はログイン画面に遷移
   before_action :authenticate_user!, except: [:top, :about]
  
  # サインイン後の遷移
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
 
 def after_sign_out_path_for(resource)
    root_path
 end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
