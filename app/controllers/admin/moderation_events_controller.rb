# frozen_string_literal: true

# Admin namespace for EventsController
module Admin
  # EventsController for Admin namespace
  class ModerationEventsController < Admin::BaseController
    before_action :authenticate_user!, only: %i[index approve decline]
    before_action :auth_with_policy, only: %i[index approve decline]
    before_action :find_events, only: %i[index]
    before_action :find_event, only: %i[approve decline]

    def index; end

    def approve
      redirect_to admin_moderation_events_path, notice: t('.approved') if @event.approve!
    end

    def decline
      redirect_to admin_moderation_events_path, notice: t('.declined') if @event.decline!
    end

    private

    def auth_with_policy
      authorize Event, policy_class: ModerationEventPolicy
    end

    def find_events
      @events = Event.where.not(aasm_state: 'approve').page(params[:page])
    end

    def find_event
      @event = Event.find(params[:id])
    end
  end
end
