# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
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

      describe 'comparing two dates' do
        start_time = DateTime.new(2021, 10, 28)
        end_time   = DateTime.new(2021, 10, 29)

        let(:good_event) { create(:event) }
        let(:bad_event)  do
          Event.new(title: 'Title', location: 'Location', organizer_email: 'email@mail.com', start_time: end_time,
                    end_time: start_time)
        end

        it { expect(good_event).to be_valid }
        it { expect(bad_event).not_to be_valid }
      end
    end
  end
end
