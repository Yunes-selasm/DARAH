module HubspotActionsHelper
  def status_color_class(status)
    case status.to_s.downcase
    when "success"
      "bg-green-500"
    when "failed"
      "bg-red-500"
    when "pending"
      "bg-orange-500"
    end
  end
  

  def action_types_dropdown
    HubspotAction.action_types.map do |k, v|
      [k.titleize, v]
    end
  end

  def statuses_dropdown
    HubspotAction.statuses.map do |k, v|
      [k.titleize, v]
    end
  end
end
