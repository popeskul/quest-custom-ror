# frozen_string_literal: true

# Admin namespace for EventsController
module Admin
  # EventsController for Admin namespace
  class EventsController < Admin::BaseController
    include AuthorizationUtils

    before_action :find_event, only: %i[show edit update destroy]
    before_action :check_event_policy, only: %i[edit update destroy]

    def edit; end

    def update
      if @event.update(event_params)
        redirect_to event_path(@event), notice: t('.success')
      else
        render :edit
      end
    end

    def destroy
      @event.destroy
      redirect_to events_path, notice: t('.success')
    end

    private

    def find_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :description, :location, :organizer_email,
                                    :organizer_telegram, :link, :start_time, :end_time)
    end

    def check_event_policy
      check_policy EventPolicy, @event
    end
  end
end
