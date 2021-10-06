# frozen_string_literal: true

# Controller for events
class Admin::EventsController < Admin::BaseController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_event, only: %i[edit update show destroy]

  def index
    @events = Event.page params[:page]
  end

  def show; end

  def new
    authorize Event

    @event = Event.new
  end

  def create
    authorize Event

    @event = Event.new(event_params.merge(author_id: current_user.id))

    if @event.save
      redirect_to admin_event_path(@event), notice: t('.success')
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
      redirect_to admin_event_path(@event), notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    authorize @event

    @event.destroy
    redirect_to admin_events_path, notice: t('.success')
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
