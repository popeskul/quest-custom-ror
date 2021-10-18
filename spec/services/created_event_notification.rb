# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::CreatedEventNotification do
  let(:existing_admin) { create(:user, admin: true) }
  let(:existing_user) { create(:user) }

  let(:existing_event) { create(:event, author: existing_user) }

  let(:mailer) { double('NotificationMailer') }
  subject { Services::CreatedEventNotification.new.call(existing_event) }

  it '#call' do
    expect(NotificationMailer).to receive(:event_created)
      .with(existing_admin, existing_event)
      .and_return(mailer)
    allow(mailer).to receive(:deliver_later)

    subject
  end
end
