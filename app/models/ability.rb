# frozen_string_literal: true

# Helps restricts what resources a given user is allowed to access
# docs https://github.com/CanCanCommunity/cancancan
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can %i[read], Event

    return unless user.present?

    can %i[manage], Event, author: user
  end
end
