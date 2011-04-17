module Company::IdentityHelper
  def is_active(id)
    id.eql?(@layout.architecture_type) ? "active" : ""
  end
end
