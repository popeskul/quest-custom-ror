# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Queries::FindNewEvents do
  let!(:user) { create(:user) }
  let!(:tag) { create(:tag) }
  let!(:events) { create_list(:event, 5, event_postable: user, tag_list: tag) }
  let!(:tag_subscription) { create(:tag_subscription, email: user.email, tags: [tag.name]) }
  let(:new_events) { Events::Queries::FindNewEvents.new(tag_subscription).call }
  let(:delivered_event) { DeliveredUserEvent.create(user: user, event: events.first) }

  it 'find new 5 events or lower' do
    expect(new_events.size).to eq 5
  end

  it 'find new 4 events without an one delivered event' do
    delivered_event
    expect(new_events).to_not contain_exactly(new_events.first)
    expect(new_events.size).to eq 4
  end
end
