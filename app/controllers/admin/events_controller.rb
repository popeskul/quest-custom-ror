# frozen_string_literal: true

# Admin namespace for EventsController
module Admin
  # EventsController for Admin namespace
  class EventsController < Admin::BaseController
    before_action :authenticate_user!
    before_action :find_event, only: %i[show edit update destroy]

    def edit
      authorize @event
    end

    def update
      authorize @event

      if @event.update(event_params)
        redirect_to event_path(@event), notice: t('.success')
      else
        render :edit
      end
    end

    def destroy
      authorize @event

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
  end
end
