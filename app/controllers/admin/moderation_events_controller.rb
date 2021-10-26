# frozen_string_literal: true

# Admin namespace for EventsController
module Admin
  # EventsController for Admin namespace
  class ModerationEventsController < Admin::BaseController
    include ModerationEventsHelper

    before_action :find_event, only: %i[approve decline]
    before_action :check_moderation_policy, only: %i[index approve decline]

    def index
      @events = Event.for_moderation.order(created_at: :asc).page(params[:page])
    end

    def approve
      if Services::ModerationEvent.new(@event).approve
        redirect_to admin_moderation_events_path, notice: t('.success')
      else
        redirect_to admin_moderation_events_path, flash: { danger: t('.failure') }
      end
    end

    def decline
      if Services::ModerationEvent.new(@event).decline
        redirect_to admin_moderation_events_path, notice: t('.success')
      else
        redirect_to admin_moderation_events_path, flash: { danger: t('.failure') }
      end
    end

    private

    def find_event
      @event = Event.find(params[:id])
    end

    def check_moderation_policy
      check_policy @event, action_name
    end
  end
end
