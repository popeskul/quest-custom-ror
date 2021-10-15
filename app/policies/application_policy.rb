# frozen_string_literal: true

# ApplicationPolicy
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
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
    user.id == record.author_id
  end

  def admin?
    user.admin if user_present?
  end
end
