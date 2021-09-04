# frozen_string_literal: true

# Controller for events
class EventsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!, except: %i[index show]
  before_action :load_event, only: %i[edit update show destroy]

  def index
    @events = Event.page params[:page]
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params.merge(author_id: current_user.id))

    if @event.save
      redirect_to @event, notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    if can?(:delete, @event) && @event.destroy
      redirect_to events_path, notice: t('.success')
    else
      redirect_to @event
    end
  end

  private

  def load_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :organizer_email,
                                  :organizer_telegram, :link, :start_time, :end_time)
  end
end
