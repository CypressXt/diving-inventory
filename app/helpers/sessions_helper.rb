module SessionsHelper
  def log_in_session(user)
    session[:user_logged_id] = user.id
  end

  def current_logged_user
    user = User.find_by(id: session[:user_logged_id])
  end

  def is_logged_in
    !session[:user_logged_id].nil? && current_logged_user.present? && !current_logged_user.id.nil?
  end

  def log_out
    session.delete(:user_logged_id)
  end

  def must_be_logged
    if !is_logged_in
      return head(:forbidden)
    end
  end

  def must_be_admin
    if !(is_logged_in and current_logged_user.admin?)
      return head(:forbidden)
    end
  end
end
