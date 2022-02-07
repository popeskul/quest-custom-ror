# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relations' do
    it { should have_many(:events).dependent(:destroy) }
    it { should have_many(:delivered_user_events).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end
end
