module ApplicationHelper
  def bootstrap_flash_class(type)
    case type
    when 'alert' then 'warning'
    when 'error' then 'danger'
    when 'notice' then 'success'
    else
      'info'
    end
  end

  def button_class(style = 'primary')
    "btn btn-sm btn-#{style}"
  end
end
