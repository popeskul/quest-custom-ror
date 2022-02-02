# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagSubscriptions::Services::SendEmailNewEvents do
  let(:user) { create(:user) }
  let(:tag_names) { %w[ruby front-end] }
  let(:tags) { tag_names.map { |tag_name| create(:tag, name: tag_name, keys: tag_name) } }
  let(:tag_subscription) { create(:tag_subscription, email: user.email, tags: tag_names) }
  let(:events) { tags.map { |tag| create(:event, event_postable: user, description: tag.name, tag_list: tag) } }

  let(:count_delivered_events) { DeliveredUserEvent.count }

  subject { TagSubscriptions::Services::SendEmailNewEvents.new(tag_subscription).call }

  describe '#call' do
    it 'deliver email with events' do
      events
      find_not_delivered_events = Events::Queries::FindNewEvents.new(tag_subscription).call
      subject

      expect(count_delivered_events).to eq find_not_delivered_events.count
    end

    it 'nothing to deliver' do
      subject

      expect(count_delivered_events).to eq 0
    end
  end
end
