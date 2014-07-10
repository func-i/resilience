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

  def show_sign_in_out
    if !user_signed_in?
      link_to t('navigation.sign_in'), new_user_session_path
    else
      link_to t('navigation.sign_out'), destroy_user_session_path, method: :delete
    end
  end
end
