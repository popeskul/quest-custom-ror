# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }

  describe '.signup_by_email' do
    let(:mail) { UserMailer.signup_by_email(user.email) }

    it 'renders the headers' do
      expect(mail.subject).to eq t('user_mailer.signup_by_email.subject')
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq [Settings.mail.from]
    end

    it 'renders the body' do
      body = mail.body.encoded
      expect(body).to match t('user_mailer.signup_by_email.title')
      expect(body).to match t('user_mailer.signup_by_email.description', email: user.email)
    end
  end
end
