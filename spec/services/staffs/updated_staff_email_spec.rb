# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staffs::Services::UpdatedStaffEmail do
  let(:existing_admin) { create(:staff) }

  let(:mailer) { double('StaffMailer') }
  subject { Staffs::Services::UpdatedStaffEmail.new.call(existing_admin) }

  it '#call' do
    expect(StaffMailer).to receive(:staff_updated)
      .with(existing_admin)
      .and_return(mailer)
    allow(mailer).to receive(:deliver_later)

    subject
  end
end
