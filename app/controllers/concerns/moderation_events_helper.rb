# frozen_string_literal: true

# Helper for ModerationEvents Controller
module ModerationEventsHelper
  def check_policy(event, action_name)
    action = "#{action_name}?".to_s
    allowed_policy = Admin::ModerationEventPolicy.new(app_current_user, event).instance_eval(action)

    raise Pundit::NotAuthorizedError, "not allowed to #{action}" unless allowed_policy
  end
end
