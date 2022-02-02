# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagSubscriptions::Services::WeeklyTagDigest do
  let(:user) { create(:user) }
  let(:tag_subscription) { create(:tag_subscription, email: user.email, tags: %w[ruby front-end]) }
  let(:events) { create_list(:event, 5, event_postable: user) }

  let(:mailer) { double('TagSubscriptionMailer') }
  subject { TagSubscriptions::Services::WeeklyTagDigest.new.send_digest(tag_subscription, events) }

  it '#send_digest' do
    expect(TagSubscriptionMailer).to receive(:digest).with(tag_subscription, events).and_return(mailer)
    allow(mailer).to receive(:deliver_later)

    subject
  end
end
