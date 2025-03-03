class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Deviseのストロングパラメータ設定
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # サインアップ時とアカウント更新時にnameとageのパラメータを許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :age ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :age ])
  end
end
