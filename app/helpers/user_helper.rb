module UserHelper
  def devise_mapping
    @devise_mapping = request.env["devise.mapping"] || Devise.mappings[:user]
  end

  def resource_name
    devise_mapping.name
  end

  def resource_class
    devise_mapping.to
  end

  def user_signed_in?
    if current_user.blank?
      link_to "Sign In", new_user_session_path
    else
      link_to "Sign Out", destroy_user_session_path, method: :delete
    end
  end
end
