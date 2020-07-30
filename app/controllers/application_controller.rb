class ApplicationController < ActionController::Base
  # CSRF対策
  protect_from_forgery with: :exception
  # 例外処理記述
  rescue_from ActiveRecord::RecordNotFound, with: :rescue404 #レコードが存在しない場合のエラー画面

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

  def rescue404(e)
    @exception = e
    render template: 'error/404_not_found', status: 404
  end

end
