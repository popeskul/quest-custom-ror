# frozen_string_literal: true

# Admin for BaseController
module Admin
  # BaseController for Admin
  class BaseController < ApplicationController
    include Pundit

    layout 'admin'

    before_action :authenticate_staff!
  end
end
