class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        message = 'Account activated. '
        redirect_back_or user
      else
        message = 'Account not activated. '
        message += 'Check your email for the activation link.'
        flash[:warning] = message

      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # ログインメソッド
  # def log_in(user)
  #   session[:user_id] = user.id
  # end

  def destroy
    log_out if logged_in?
    redirect_to signup_path
  end

  # かんたんログインの実装
  def guest_login
    user = User.find_or_create_by(name: 'Guest', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end

    session[:user_id] = user.id

    log_in user
    redirect_to all_item_show_path(user_id: session[:user_id]), notice: 'ゲストユーザーとしてログインしました。'
  end
end
