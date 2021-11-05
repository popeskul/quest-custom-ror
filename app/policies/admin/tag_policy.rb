# frozen_string_literal: true

# Staff policy
module Admin
  # Tag policy
  class TagPolicy < ApplicationPolicy
    def index?
      admin?
    end

    def show?
      false
    end

    def create?
      admin?
    end

    def edit?
      admin?
    end

    def update?
      admin?
    end

    def destroy?
      admin?
    end
  end
end
