# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:event) { create(:event, author_id: user.id) }

  describe '#destroy' do
    let(:delete_event) { delete :destroy, params: { id: event.id } }

    context 'If event belongs to the user' do
      before { login(user) }

      it 'successfully delete the event' do
        expect { delete_event }.to change(Event, :count).by(-1)
      end

      it 'successfully redirects to index' do
        delete_event
        expect(response).to redirect_to events_path
      end
    end

    context 'If event does not belong to the user' do
      before { login(create(:user)) }

      it 'con not delete another event' do
        expect { delete_event }.to_not change(Event, :count)
      end

      it 're-renders edit view' do
        delete_event
        expect(response).to redirect_to event
      end
    end
  end
end
