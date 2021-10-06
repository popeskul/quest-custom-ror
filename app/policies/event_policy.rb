# frozen_string_literal: true

# EventPolicy
class EventPolicy < ApplicationPolicy
  def new?
    present?
  end

  def edit?
    author? if present?
  end

  def create?
    present?
  end

  def destroy?
    author? if present?
  end

  def update?
    author? if present?
  end

  private

  def present?
    user.present?
  end

  def author?
    user.id == record.author_id
  end
end
