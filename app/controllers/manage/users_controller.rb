class Manage::UsersController < Manage::BaseController
  respond_to :html

  def index
    @search = Manage::UserSearch.new(params[:search])
    @user_search_form = Manage::UsersSearchForm.new @search.get_searches,
      params[:search]
    users = @search.results.page(current_page).order(sorting)
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

    if @user.update_attributes policy(@user).update_params(params)
      flash[:notice] = t('manage.controllers.users.update.notice')
    end

    respond_with [:manage, @user]
  end

  def destroy
    @user = User.find params[:id]

    if @user.destroy
      flash[:notice] = t('manage.controllers.users.destroy.notice')
    end

    respond_with [:manage, @user]
  end

  private

  def sorting
    if sort_column.present?
      sort_by
    else
      set_default_sorting('users', 'created_at', 'desc')
    end
  end
end
