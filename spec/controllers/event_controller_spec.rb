# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  let(:event) { create(:event, author_id: user.id) }
  let(:event2) { create(:event, author_id: user2.id) }

  let(:delete_event) { delete :destroy, params: { id: event.id } }
  let(:delete_event2) { delete :destroy, params: { id: event2.id } }

  describe '#create' do
    before { login(user) }

    context 'with valid attributes' do
      subject { post :create, params: { event: attributes_for(:event) } }

      it 'save a new event' do
        expect { subject }.to change(Event, :count).by(1)
      end

      it 'redirects to show' do
        subject
        expect(response).to redirect_to assigns(:event)
      end
    end

    context 'with invalid attributes' do
      before { event }

      subject { post :create, params: { event: attributes_for(:event, :invalid_dates), format: :js } }

      it 'does not save the new event in the database' do
        expect { subject }.to_not change(Event, :count)
      end

      it 're-renders new view' do
        subject
        expect(response).to render_template :new
      end
    end
  end

  describe '#destroy' do
    before do
      allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil }
      login(user)
    end

    context 'If event belongs to the user' do
      it 'successfully delete the event' do
        event
        expect { delete_event }.to change(Event, :count).by(-1)
      end

      it 'successfully redirects to index' do
        delete_event
        expect(response).to redirect_to events_path
      end
    end

    context 'If event does not belong to the user' do
      it 'con not delete another event' do
        event2
        expect { delete_event2 }.to_not change(Event, :count)
      end

      it 're-renders show view' do
        delete_event2
        expect(response).to redirect_to event2
      end
    end
  end

  describe '#edit' do
    before do
      login(user)
      get :edit, params: { id: event.id }
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe '#index' do
    let(:events) { create_list(:event, 15, author_id: user.id) }

    before do
      login(user)
      get :index
    end

    it 'returns the correct array of events' do
      expect(events).to match_array(events)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe '#new' do
    before do
      login(user)
      get :new
    end

    it 'assigns a new Event to @event' do
      expect(assigns(:event)).to be_a_new(Event)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe '#show' do
    before do
      login(user)
      get :show, params: { id: event.id }
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe '#update' do
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
end
