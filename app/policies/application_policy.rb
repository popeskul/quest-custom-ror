# frozen_string_literal: true

# ApplicationPolicy
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record = nil)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  private

  def user_present?
    user.present?
  end

  def author?
    user.id == record&.event_postable_id
  end

  def admin?
    Staff == user.class if user_present?
  end
end
