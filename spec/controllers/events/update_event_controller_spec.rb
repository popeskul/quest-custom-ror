# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { create(:event) }
  let!(:user) { create(:user) }

  before { login(user) }

  context 'Update with valid attributes' do
    it 'changes event attributes' do
      patch :update, params: { id: event, event: { title: 'new title' } }
      event.reload
      expect(event.title).to eq 'new title'
    end

    it 'redirect to updated event' do
      patch :update, params: { id: event, event: attributes_for(:event) }

      expect(response).to redirect_to event_path(Event.last)
    end
  end

  context 'Update with invalid attributes' do
    before { patch :update, params: { id: event, event: attributes_for(:event, :invalid_dates), format: :js } }

    it 'does not change event' do
      event.reload
      expect(assigns(:event)).not_to eq event.title
    end

    it 're-renders edit view' do
      expect(response).to render_template(:edit)
    end
  end
end
