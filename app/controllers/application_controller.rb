class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    if resource_class == User
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :prefecture_id])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :image, :prefecture_id])
    elsif resource_class == Producer
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile,:prefecture_id])
    else
      super
    end
  end

  def user_signed?
    @u = User.find(current_user)
  end
end
