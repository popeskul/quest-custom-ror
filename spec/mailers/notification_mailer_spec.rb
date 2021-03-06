# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationMailer, type: :mailer do
  describe '.event_created' do
    let(:users) { create_list(:staff, 2) }
    let(:event) { create(:event) }

    it 'renders the headers' do
      users.each do |user|
        mail = NotificationMailer.event_created(user, event)

        expect(mail.subject).to eq t('notification_mailer.event_created.subject')
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq([Settings.mail.from])
        expect(mail.body.encoded).to match(event.title)
      end
    end
  end
end
