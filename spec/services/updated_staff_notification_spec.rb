# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::UpdatedStaffNotification do
  let(:existing_admin) { create(:staff) }

  let(:mailer) { double('StaffMailer') }
  subject { Services::UpdatedStaffNotification.new.call(existing_admin) }

  it '#call' do
    expect(StaffMailer).to receive(:staff_updated)
      .with(existing_admin)
      .and_return(mailer)
    allow(mailer).to receive(:deliver_later)

    subject
  end
end
