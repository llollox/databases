module ApplicationHelper
  def command_label icon, label
    "<i class='#{icon} icon-white'></i> <span class='command-label'>&nbsp;#{label}</span>".html_safe
  end

  def arrow_label label
    raw("<i class=\"fa fa-chevron-right\"></i>" + "#{label}")
  end

  def separate_comma(number)
    number.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(".").reverse
  end

  def separate_comma_decimals(number)
    number = number.to_s.split(".")
    separate_comma(number[0]) + "," + number[1]
  end

  def active path
    return "active" if path.is_a?(Symbol) && action_name == path.to_s
    return "active" if path.is_a?(String) && request.url.include?(path)
  end

  def partial_name
    case action_name
      when "all" 
        return "index" 
      else 
        return action_name
    end
  end

  def form_action
    return "New" if action_name == "new" || action_name == "create"
    return "Edit" if action_name == "edit" || action_name == "Update"
  end

  def submit_class
    return "btn-success" if action_name == "new" || action_name == "create"
    return "btn-primary" if action_name == "edit" || action_name == "Update"
  end

end
