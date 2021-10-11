# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do
  let(:admin) { create(:user, admin: true) }
  let(:admin2) { create(:user, admin: true) }

  let!(:event) { create(:event, author_id: admin.id) }
  let(:event2) { create(:event, author_id: admin2.id) }

  let(:delete_event) { delete :destroy, params: { id: event.id } }
  let(:delete_event2) { delete :destroy, params: { id: event2.id } }

  context 'GET #edit' do
    describe 'author of the event' do
      before do
        login(admin)
        get :edit, params: { id: event.id }
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end

    describe 'not author of the event' do
      before do
        login(admin)
        get :edit, params: { id: event2.id }
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update' do
    before { login(admin) }

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

  describe 'DELETE #destroy' do
    context 'authenticated user' do
      context 'deletes his event' do
        before { login(admin) }

        it 'successfully delete the event' do
          event
          expect { delete_event }.to change(Event, :count).by(-1)
        end

        it 'successfully redirects to index' do
          delete_event
          expect(response).to redirect_to events_path
        end
      end

      context 'deletes not his event' do
        before { login(admin) }

        it 'successfully delete the event' do
          event2
          expect { delete_event2 }.to change(Event, :count).by(-1)
        end
      end
    end

    context 'not authenticated user' do
      it 'con not delete question' do
        expect { delete_event }.to_not change(Event, :count)
      end

      it 'redirects to login page' do
        delete_event
        expect(response).to redirect_to root_path
      end
    end
  end
end
