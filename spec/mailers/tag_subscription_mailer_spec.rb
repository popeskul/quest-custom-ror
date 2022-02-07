# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagSubscriptionMailer, type: :mailer do
  let(:tags) { ['ruby'] }
  let(:user) { create(:user) }
  let(:events) { create_list(:event, 10) }
  let(:tag_subscription) { create(:tag_subscription, email: user.email, tags: tags) }

  describe '.subscription_created' do
    let(:mail) { TagSubscriptionMailer.subscription_created(tag_subscription) }

    it 'renders the headers' do
      expect(mail.subject).to eq t('tag_subscription_mailer.subscription_created.subject')
      expect(mail.to).to eq [tag_subscription.email]
      expect(mail.from).to eq [Settings.mail.from]
    end

    it 'renders the body' do
      body = mail.body.encoded
      expect(body).to match t('tag_subscription_mailer.subscription_created.title')
      expect(body).to match t('tag_subscription_mailer.subscription_created.description', email: user.email)
      expect(body).to match tags.first
    end
  end

  describe '.digest' do
    let(:mail) { TagSubscriptionMailer.digest(tag_subscription, events) }

    it 'renders the headers' do
      expect(mail.subject).to eq t('tag_subscription_mailer.digest.subject')
      expect(mail.to).to eq [tag_subscription.email]
      expect(mail.from).to eq [Settings.mail.from]
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match t('tag_subscription_mailer.digest.title')
      expect(mail.body.encoded).to match t('tag_subscription_mailer.digest.description', email: user.email)
    end

    it 'checks first 5 events' do
      body = mail.body.encoded
      events.first(Events::Queries::FindNewEvents::LIMIT_OF_EVENTS).map do |event|
        expect(body).to include "/events/#{event.id}"
      end
    end
  end
end
