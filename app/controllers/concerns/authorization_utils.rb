# frozen_string_literal: true

# Helper for Events Controller
module AuthorizationUtils
  def check_policy(event, action_name)
    action = "#{action_name}?".to_s
    allowed_policy = EventPolicy.new(app_current_user, event).instance_eval(action)

    raise Pundit::NotAuthorizedError, "not allowed to #{action}" unless allowed_policy
  end
end
