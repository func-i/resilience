module ResourceHelper

  def edit_action resource
    icon = content_tag(:i, nil, class: 'fi-page-edit').html_safe

    link_to(icon,
      polymorphic_path([:edit, *namespace, *resource]),
      class: 'edit',
      title: t('views.defaults.actions.edit')).html_safe
  end

  def destroy_action resource
    icon = content_tag(:i, nil, class: 'fi-page-delete').html_safe

    link_to(icon,
      polymorphic_path([*namespace, *resource]),
      data: {confirm: 'Are you sure ?'},
      class: 'delete',
      title: t('views.defaults.actions.destroy'),
      method: :delete).html_safe
  end

  def show_action resource
    icon = content_tag(:i, nil, class: 'fi-page').html_safe

    link_to(icon,
      polymorphic_path([*namespace, *resource]),
      class: 'show',
      title: t('views.defaults.actions.show')).html_safe
  end

  private

  def namespace
    controller_namespace = controller_path.split('/')
    controller_namespace.pop
    controller_namespace
  end

end
