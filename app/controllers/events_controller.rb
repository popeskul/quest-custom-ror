class EventsController < ApplicationController
  before_action :set_event, only: %i[edit update show]

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

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Your event successfully updated.'
    else
      redirect_to :edit
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
