# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ModerationEventsController, type: :controller do
  let(:user_adam) { create(:staff) }
  let(:user_eva) { create(:staff) }

  let!(:existing_events) { create_list(:event, 2, event_postable: user_adam) }
  let!(:existing_event2) { create(:event, event_postable: user_eva) }
  let!(:declined_event)  { create(:event, :declined, event_postable: user_eva) }

  let(:approve_event2) { patch :approve, params: { id: existing_event2.id } }
  let(:decline_event2) { patch :decline, params: { id: existing_event2.id } }

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

    context 'previously approved' do
      before { existing_event2.approve! }

      it 'user can not approve a twice' do
        approve_event2

        expect(response).to redirect_to admin_moderation_events_path
        expect(flash[:danger]).to eq t('admin.moderation_events.approve.failure')
      end
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

    context 'previously declined' do
      before { declined_event }

      it 'user can not approve a twice' do
        patch :decline, params: { id: declined_event.id }

        expect(response).to redirect_to admin_moderation_events_path
        expect(flash[:danger]).to eq t('admin.moderation_events.decline.failure')
      end
    end
  end
end
