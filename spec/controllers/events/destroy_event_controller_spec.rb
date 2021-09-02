# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { create(:event) }
  let!(:user) { create(:user) }

  before { sign_in(user) }

  describe '#destroy' do
    let!(:event) { create(:event) }
    let(:delete_event) { delete :destroy, params: { id: event.id } }

    it 'successfully delete the event' do
      expect { delete_event }.to change(Event, :count).by(-1)
    end

    it 'successfully redirects to index' do
      delete_event
      expect(response).to redirect_to events_path
    end
  end
end
