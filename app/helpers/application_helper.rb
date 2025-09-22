module ApplicationHelper
  def flash_class(key)
    case key.to_sym
    when :notice, :success
      "alert-success"
    when :alert, :warning
      "alert-warning"
    when :error, :danger
      "alert-danger"
    else
      "alert-info"
    end
  end

end
