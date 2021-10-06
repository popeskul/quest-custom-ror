# frozen_string_literal: true

# Controller for events
class EventsController < ApplicationController
  before_action :find_events, only: %i[index]

  def index; end

  private

  def find_events
    @events = Event.page(params[:page])
  end
end
