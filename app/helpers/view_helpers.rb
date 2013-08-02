helpers do
  def active_for(path, position = :ends)
    case position
    when :ends
      path_match = /#{request.path_info}$/ =~ path
    when :starts
      path_match = /^#{request.path_info}/ =~ path
    when :includes
      path_match = /#{request.path_info}/ =~ path
    end

    if path_match
      "active"
    end
  end
end
