# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ModerationEventsController, type: :controller do
  let(:user_adam) { create(:user, admin: true) }
  let(:user_eva) { create(:user, admin: true) }

  let!(:existing_events) { create_list(:event, 2, author_id: user_adam.id) }
  let!(:existing_event2) { create(:event, author_id: user_eva.id) }

  context 'GET #index' do
    before do
      login(user_adam)
      get :index
    end

    it 'returns the correct array of events' do
      expect(existing_events).to match_array(existing_events)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  context 'PATCH #approve' do
    before { login(user_adam) }

    it 'change own an event to approve' do
      patch :approve, params: { id: existing_event2.id }
      expect(assigns('event').aasm_state).to eq 'approved'
    end

    it 'change not own an event to approve' do
      patch :approve, params: { id: existing_events[0].id }
      expect(assigns('event').aasm_state).to eq 'approved'
    end
  end

  context 'PATCH #decline' do
    before { login(user_adam) }

    it 'change own an event to decline' do
      patch :decline, params: { id: existing_event2.id }
      expect(assigns('event').aasm_state).to eq 'declined'
    end

    it 'change not own an event to decline' do
      patch :decline, params: { id: existing_events[0].id }
      expect(assigns('event').aasm_state).to eq 'declined'
    end
  end
end
