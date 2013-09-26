class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  include UsersHelper
  include SecretnumbersHelper

  before_filter :signed_in_user, only: [:edit, :update, :show_all_users, :index, :logic]
  before_filter :correct_user,   only: [:edit, :update]

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end


  protected

    def signed_in_user
      redirect_to signin_url, notice: "Pojaluysta, avtorizuytes!" unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
