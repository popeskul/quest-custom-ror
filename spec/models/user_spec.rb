# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  include_examples 'model has relations'

  include_examples 'model has validations'
end
