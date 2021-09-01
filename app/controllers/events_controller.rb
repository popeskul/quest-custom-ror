class EventsController < ApplicationController
  before_action :set_event, only: %i[edit update show destroy]

  def index
    @events = Event.page params[:page]
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'Your event successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Your event successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = 'Event was successfully deleted.'
      redirect_to events_path
    else
      redirect_to @event
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :organizeremail,
                                  :organizertelegram, :link, :starttime, :endtime)
  end
end
