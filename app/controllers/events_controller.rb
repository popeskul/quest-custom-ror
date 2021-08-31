class EventsController < ApplicationController
  def index
    @events = Event.page params[:page]
  end
end
