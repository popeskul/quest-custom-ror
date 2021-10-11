# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Relations' do
    it { should belong_to(:author) }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :location }

    context 'validate email' do
      it { should     allow_value('valid@mail.com').for(:organizer_email) }
      it { should_not allow_value('wrong').for(:organizer_email) }
    end

    context 'validate dates' do
      it { should validate_presence_of :start_time }
      it { should validate_presence_of :end_time }

      it { should_not allow_value('').for(:start_time) }
      it { should_not allow_value('').for(:end_time) }
    end
  end
end
