# frozen_string_literal: true

# Helper for Events Controller
module AuthorizationUtils
  def check_policy(policy, record, default_action = action_name)
    action = "#{default_action}?".to_s
    allowed_policy = policy.new(app_current_user, record).instance_eval(action)

    raise Pundit::NotAuthorizedError, "not allowed to #{action}" unless allowed_policy
  end
end
