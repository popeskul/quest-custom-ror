# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Queries::FindNewEvents do
  let!(:user) { create(:user) }
  let!(:tag) { create(:tag) }
  let!(:events) { create_list(:event, 5, event_postable: user, tag_list: tag) }
  let!(:tag_subscription) { create(:tag_subscription, email: user.email, tags: [tag.name]) }
  let(:find_new_events) { Events::Queries::FindNewEvents.new(tag_subscription).call }
  let(:delivered_first_event) do
    create(:delivered_tag_subscription,
           email: user.email,
           tag_subscription_id: tag_subscription.id,
           event_ids: [events.first&.id])
  end

  it 'find new 5 events or lower' do
    expect(find_new_events.size).to eq 5
  end

  it 'find new 4 events without an one delivered event' do
    delivered_first_event
    DeliveredTagSubscription.all.reload

    delivered_event_ids = DeliveredTagSubscription.first&.event_ids&.first
    without_delivered = events.map(&:id).reject { |id| delivered_event_ids.include?(id.to_s) }

    expect(find_new_events.map(&:id)).to match_array(without_delivered)
    expect(find_new_events.size).to eq 4
  end
end
