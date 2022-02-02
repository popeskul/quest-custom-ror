# frozen_string_literal: true

# TagSubscriptionPolicy
class TagSubscriptionPolicy < ApplicationPolicy
  def index?
    false
  end

  def new?
    true
  end

  def show?
    false
  end

  def create?
    true
  end

  def edit?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
