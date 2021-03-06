# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Relations' do
    it { should belong_to(:event_postable) }
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

  describe 'State machine' do
    let(:event) { Event.new }

    it { expect(event).to have_state(:pending) }

    describe 'move to approve' do
      it { expect(event).to transition_from(:pending).to(:approved).on_event(:approve) }
      it { expect(event).to transition_from(:declined).to(:approved).on_event(:approve) }
    end

    describe 'move to decline' do
      it { expect(event).to transition_from(:approved).to(:declined).on_event(:decline) }
      it { expect(event).to transition_from(:pending).to(:declined).on_event(:decline) }
    end
  end

  describe 'tag_list' do
    let(:event) { create(:event) }

    it 'user can see all tags' do
      expect(event.tag_list).to eq []
    end

    it 'user can add tag' do
      tag_name = 'tag1'
      expect { event.tag_list.add(tag_name) }.to change(event, :tag_list)
    end

    it 'user can remove tag' do
      event.tag_list.add('tag1', 'tag2')

      expect { event.tag_list.remove('tag1') }.to change(event, :tag_list)
      expect(event.tag_list).to eq ['tag2']
    end
  end

  describe 'Scopes' do
    let(:user) { create(:user) }
    let(:event) { create(:event, event_postable: user) }

    it '.for_moderation' do
      event
      expect(Event.for_moderation.uniq).to eq [event]
    end
  end
end
