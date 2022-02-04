# frozen_string_literal: true

# Controller for events
class EventsController < ApplicationController
  include AuthorizationUtils

  before_action :authenticate_app_current_user!, only: %i[new create edit update destroy]
  before_action :find_event, only: %i[show edit update destroy]
  before_action :find_tags, only: %i[new create edit]
  before_action :check_event_policy, only: %i[new create edit update destroy]

  def index
    @events = Event.approved.page(params[:page])
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = Events::Services::CreateEvent.new(app_current_user, event_params).call

    if @event.save
      redirect_to event_path(@event), notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if Events::Services::Update.new(@event, event_params).call
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

  def find_tags
    @tags = ActsAsTaggableOn::Tag.all
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :organizer_email, :organizer_telegram,
                                  :link, :start_time, :end_time, tag_list: [])
  end

  def check_event_policy
    check_policy EventPolicy, @event
  end
end
