# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeliveredUserEvent, type: :model do
  describe 'Relations' do
    it { should belong_to(:user) }
    it { should belong_to(:event) }
  end

  describe 'Scopes' do
    let!(:event) { create(:event) }
    let!(:user) { create(:user) }
    let!(:delivered_user_event) { create(:delivered_user_event, user: user, event: event) }

    it '.delivered_by' do
      found_delivered = DeliveredUserEvent.delivered_by(event_id: event.id, user_id: user.id).first

      expect(found_delivered.event_id).to eq delivered_user_event.event_id
      expect(found_delivered.user_id).to eq delivered_user_event.user_id
    end
  end
end
