# frozen_string_literal: true

# Helper for Staffs Controller
module StaffsHelper
  def check_policy(staff, action_name)
    action = "#{action_name}?".to_s
    allowed_policy = Admin::StaffPolicy.new(app_current_user, staff).instance_eval(action)

    raise Pundit::NotAuthorizedError, "not allowed to #{action}" unless allowed_policy
  end
end
