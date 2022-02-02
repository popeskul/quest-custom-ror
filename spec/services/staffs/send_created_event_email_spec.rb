# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staffs::Services::SendCreatedEventEmail do
  let(:existing_admin) { create(:staff) }
  let(:existing_event) { create(:event, event_postable: existing_admin) }

  let(:mailer) { double('NotificationMailer') }
  subject { Staffs::Services::SendCreatedEventEmail.new.call(existing_event) }

  it '#call' do
    expect(NotificationMailer).to receive(:event_created)
      .with(existing_admin, existing_event)
      .and_return(mailer)
    allow(mailer).to receive(:deliver_later)

    subject
  end
end
