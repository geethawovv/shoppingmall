module ApplicationHelper
  def flash_class(level) 
    case level.to_sym
      when :info then "alert alert-info"
      when :notice then "alert alert-success"
      when :alert then "alert alert-danger"
      when :warning then "alert alert-warning"
    end
  end
end
