# frozen_string_literal: true

# Admin namespace for EventsController
module Admin
  # EventsController for Admin namespace
  class ModerationEventsController < Admin::BaseController
    before_action :auth_with_policy, only: %i[index approve decline]
    before_action :find_event, only: %i[approve decline]

    def index
      @events = Event.where.not(aasm_state: 'approve').order(created_at: :asc).page(params[:page])
    end

    def approve
      if Services::Event.new(@event).approve
        redirect_to admin_moderation_events_path, notice: t('.success')
      else
        redirect_to admin_moderation_events_path, flash: { danger: t('.failure') }
      end
    end

    def decline
      if Services::Event.new(@event).decline
        redirect_to admin_moderation_events_path, notice: t('.success')
      else
        redirect_to admin_moderation_events_path, flash: { danger: t('.failure') }
      end
    end

    private

    def auth_with_policy
      authorize Event, policy_class: ModerationEventPolicy
    end

    def find_event
      @event = Event.find(params[:id])
    end
  end
end
