class Manage::UsersController < Manage::BaseController
  respond_to :html

  def index
    users = User.page(params[:page] || 0).per(1)
    @users = Manage::UserCollectionDecorator.new(users, view_context)
    respond_with [:manage, @users]
  end

  def show
    user = User.find params[:id]
    @user = Manage::UserDecorator.new user, view_context
    respond_with [:manage, @user]
  end

  def edit
    @user = User.find params[:id]
    respond_with [:manage, @user]
  end

  def update
    @user = User.find params[:id]
    update_params = Manage::UserPolicy.new(current_user, @user).
      update_attributes(params)

    if !@user.update_attributes update_params
      flash[:alert] = t('manage.controllers.users.update.notice')
    end

    respond_with [:manage, @user]
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy

    respond_with [:manage, @user]
  end
end
