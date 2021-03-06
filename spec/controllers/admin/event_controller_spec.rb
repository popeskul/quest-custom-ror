# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do
  let(:admin)  { create(:staff) }
  let(:admin2) { create(:staff) }

  let!(:existing_event) { create(:event, event_postable: admin) }
  let!(:existing_event2) { create(:event, event_postable: admin2) }

  let(:delete_event) { delete :destroy, params: { id: existing_event.id } }
  let(:delete_event2) { delete :destroy, params: { id: existing_event2.id } }

  context 'GET #edit' do
    describe 'author of the event' do
      before do
        login(admin)
        get :edit, params: { id: existing_event.id }
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end

    describe 'not author of the event' do
      before do
        login(admin)
        get :edit, params: { id: existing_event2.id }
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update' do
    let(:update_event) { patch :update, params: { id: existing_event, event: attributes_for(:event) } }

    before { login(admin) }

    context 'Update with valid attributes' do
      it 'changes event attributes' do
        patch :update, params: { id: existing_event, event: { title: 'new title' } }
        existing_event.reload
        expect(existing_event.title).to eq 'new title'
      end

      it 'redirect to updated event' do
        update_event

        expect(response).to redirect_to event_path existing_event
      end
    end

    context 'Update with invalid attributes' do
      before do
        patch :update, params: { id: existing_event, event: attributes_for(:event, :invalid_dates), format: :js }
      end

      it 'does not change event' do
        existing_event.reload
        expect(assigns(:existing_event)).not_to eq existing_event.title
      end

      it 're-renders edit view' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'authenticated admin' do
      context 'deletes his event' do
        before { login(admin) }

        it 'successfully delete the event' do
          existing_event
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
          existing_event2
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
        expect(response).to redirect_to new_staff_session_path
      end
    end
  end
end
