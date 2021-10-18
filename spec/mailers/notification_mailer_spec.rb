# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationMailer, type: :mailer do
  describe 'event_created' do
    let(:user)    { create(:user, admin: true) }
    let(:event)   { create(:event) }
    let(:mail)    { NotificationMailer.event_created(user, event) }

    it 'renders the headers' do
      expect(mail.subject).to eq t('notification_mailer.event_created.subject')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['me@qustom-ror.org'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(event.title)
    end
  end
end
