# frozen_string_literal: true

# Controller for events
class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :find_events, only: %i[index]
  before_action :find_event, only: %i[show edit update destroy]

  def index; end

  def show; end

  def new
    authorize Event

    @event = Event.new
  end

  def create
    authorize Event

    @event = current_user.events.new(event_params)

    if @event.save
      redirect_to event_path(@event), notice: t('.success')
    else
      render :new
    end
  end

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

  def find_events
    @events = Event.page(params[:page])
  end

  def find_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :organizer_email,
                                  :organizer_telegram, :link, :start_time, :end_time)
  end
end
