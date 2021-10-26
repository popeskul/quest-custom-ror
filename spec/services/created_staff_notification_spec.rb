# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::CreatedStaffNotification do
  let(:existing_admin) { create(:staff) }

  let(:mailer) { double('ActionMailer') }
  subject { Services::CreatedStaffNotification.new.call(existing_admin) }

  it '#call' do
    expect(existing_admin).to receive(:send_reset_password_instructions)
      .and_return(mailer)
    allow(mailer).to receive(:deliver_later)

    subject
  end
end
