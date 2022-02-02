# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagSubscriptions::Services::SendWeeklyDigest do
  let(:users) { create_list(:user, 2) }
  let(:tag_names) { %w[ruby front-end] }
  let(:tag_subscriptions) { users.map { |user| create(:tag_subscription, email: user.email, tags: tag_names) } }

  let(:send_email_service) { double('TagSubscriptions::Services::SendEmailNewEvents') }
  subject { TagSubscriptions::Services::SendWeeklyDigest.new.call }

  describe '#send_digest' do
    it 'send for one tag subscription' do
      allow(send_email_service).to receive(:call).with(tag_subscriptions[0])

      subject
    end

    it 'send for few tag subscription' do
      tag_subscriptions.each do |tag_subscription|
        allow(send_email_service).to receive(:call).with(tag_subscription)
      end

      subject
    end
  end
end
