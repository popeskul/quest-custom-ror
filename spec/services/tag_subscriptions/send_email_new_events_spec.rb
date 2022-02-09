# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagSubscriptions::Services::SendEmailNewEvents do
  let(:user) { create(:user) }
  let(:tag_names) { %w[ruby front-end] }
  let(:tags) { tag_names.map { |tag_name| create(:tag, name: tag_name, keys: tag_name) } }
  let(:tag_subscription) { create(:tag_subscription, email: user.email, tags: tag_names) }
  let(:events) { tags.map { |tag| create(:event, event_postable: user, description: tag.name, tag_list: tag) } }

  let(:delivered_event) { DeliveredTagSubscription.find_by(tag_subscription_id: tag_subscription.id) }
  let(:create_delivered_event) { create(:delivered_tag_subscription, tag_subscription_id: tag_subscription.id) }

  subject { TagSubscriptions::Services::SendEmailNewEvents.new(tag_subscription).call }

  describe '#call' do
    describe 'context with events' do
      before { events }

      it 'deliver email' do
        find_not_delivered_events = Events::Queries::FindNewEvents.new(tag_subscription).call
        subject

        expect(delivered_event.event_ids.count).to eq find_not_delivered_events.count
      end

      it 'create the new DeliveredTagSubscription' do
        expect { subject }.to change(DeliveredTagSubscription, :count).by(1)
      end

      it "doesn't create new DeliveredTagSubscription but update" do
        create_delivered_event

        expect { subject }.not_to change(DeliveredTagSubscription, :count)
      end
    end

    it 'nothing to deliver' do
      subject

      expect(delivered_event).to eq nil
    end
  end
end
