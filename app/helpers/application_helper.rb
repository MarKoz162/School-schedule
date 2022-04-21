module ApplicationHelper

  def bollean_value(value)
    return "NO" unless value

    "YES"
  end

  def status_label(status)
    case status
      when "confirmed"
        content_tag(:span, status.titleize, class: "badge bg-success")
      when "planned"
        content_tag(:span, status.titleize, class: "badge bg-primary")
      when "cancelled"
        content_tag(:span, status.titleize, class: "badge bg-danger")
      when "attended"
        content_tag(:span, status.titleize, class: "badge bg-info")
      when "not_attended"
        content_tag(:span, status.titleize, class: "badge bg-warning")

    end
  end

end
