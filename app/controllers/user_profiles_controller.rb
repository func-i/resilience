class UserProfilesController < ApplicationController
  before_action :authenticate_user!

  respond_to :html

  def edit
    @user = current_user
    respond_with @user
  end

  def update
    @user = current_user

    password_changed = params[:user][:password].present?

    if @user.update(update_attributes)
      sign_in @user, bypass: true if password_changed
      flash[:notice] = "Profile was successfully updated"
    end

    respond_with @user,
      location: edit_user_profile_path(current_user)
  end

  private

  def update_attributes
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    params.require(:user).
      permit(:name,
        :email,
        :password,
        :password_confirmation,
        :title,
        :organization,
        :phone,
        :website)
  end
end
