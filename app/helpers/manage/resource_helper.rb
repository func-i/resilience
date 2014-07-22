module Manage::ResourceHelper

  def edit_action resource
    icon = content_tag(:i, nil, class: 'fi-page-edit').html_safe

    link_to(icon,
      polymorphic_path([:edit, :manage, *resource]),
      class: 'edit',
      title: t('manage.views.actions.edit')).html_safe
  end

  def destroy_action resource
    icon = content_tag(:i, nil, class: 'fi-page-delete').html_safe

    link_to(icon,
      polymorphic_path([:manage, *resource]),
      data: {confirm: 'Are you sure ?'},
      class: 'delete',
      title: t('manage.views.actions.destroy'),
      method: :delete).html_safe
  end

  def show_action resource
    icon = content_tag(:i, nil, class: 'fi-page').html_safe

    link_to(icon,
      polymorphic_path([:manage, *resource]),
      class: 'show',
      title: t('manage.views.actions.show')).html_safe
  end

end
