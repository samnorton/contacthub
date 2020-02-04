module ApplicationHelper

  def has_error?(resource, field)
    resource.errors.messages[field].present?
 end

  def get_error(resource, field)
    msg = resource.errors.messages[field]
    field.to_s.capitalize + " " + msg.join(' and ') + '.'
  end

  def active_class(link_path)
    current_page?(link_path) ? 'active-menu' : ''
  end

  def active_class_white(link_path)
    current_page?(link_path) ? 'active-menu-white' : ''
  end


end
