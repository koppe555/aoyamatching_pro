class ApplicationController < ActionController::Base

  helper_method :require_logged_in_user

  add_flash_types :success, :info, :warning, :danger


  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end



  def require_logged_in_user
    unless current_user
      flash[:alert] = "ログインしてください"
      redirect_to root_path
    end
  end
end
