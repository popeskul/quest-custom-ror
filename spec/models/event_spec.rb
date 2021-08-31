require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :location }

    context 'validate email' do
      it { should     allow_value('valid@mail.com').for(:organizeremail) }
      it { should_not allow_value('').for(:organizeremail) }
      it { should_not allow_value('wrong').for(:organizeremail) }
    end

    context 'validate dates' do
      it { should validate_presence_of :starttime }
      it { should validate_presence_of :endtime }

      it { should_not allow_value('').for(:starttime) }
      it { should_not allow_value('').for(:endtime) }

      describe 'comparing two dates' do
        starttime = DateTime.new(2021, 10, 28, 0, 0, 0)
        endtime = DateTime.new(2021, 10, 29, 0, 0, 0)

        let(:good_event) { Event.new(title: 'Title', location: 'Location', organizeremail: 'email@mail.com', starttime: starttime, endtime: endtime) }
        let(:bad_event) { Event.new(title: 'Title', location: 'Location', organizeremail: 'email@mail.com', starttime: endtime, endtime: starttime) }

        it { good_event.should be_valid }
        it { bad_event.should_not be_valid }
      end
    end
  end
end
