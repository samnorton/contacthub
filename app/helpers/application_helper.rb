module ApplicationHelper
  def has_error?(resource, field)
     resource.errors.messages[field].present?
  end

  def get_error(resource, field)
    msg = resource.errors.messages[field]
    field.to_s.capitalize + " " + msg.join(' and ') + '.'
  end
end
