# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaffMailer, type: :mailer do
  describe '.staff_updated' do
    let(:admins) { create_list(:staff, 2) }

    it 'renders the headers' do
      admins.each do |user|
        mail = StaffMailer.staff_updated(user)

        expect(mail.subject).to eq t('staff_mailer.staff_updated.subject')
        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq([Settings.mail.from])
      end
    end
  end
end
