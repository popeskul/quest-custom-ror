# frozen_string_literal: true

# EventPolicy
class EventPolicy < ApplicationPolicy
  def new?
    user_present?
  end

  def show?; end

  def edit?
    author? or admin? if user_present?
  end

  def create?
    user_present?
  end

  def destroy?
    author? or admin? if user_present?
  end

  def update?
    author? or admin? if user_present?
  end
end
