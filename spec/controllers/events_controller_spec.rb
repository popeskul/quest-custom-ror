require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { create(:event) }

  describe '#index' do
    let(:events) { create_list(:event, 15) }

    before { get :index }

    it 'returns the correct array of events' do
      expect(events).to match_array(events)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe '#new' do
    before { get :new }

    it 'assigns a new Event to @event' do
      expect(assigns(:event)).to be_a_new(Event)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      subject { post :create, params: { event: attributes_for(:event), format: :js } }

      it 'save a new answer' do
        expect { subject }.to change(Event, :count).by(1)
      end

      it 'redirects to show' do
        subject
        expect(response).to redirect_to assigns(:event)
      end
    end

    context 'with invalid attributes' do
      subject { post :create, params: { event: attributes_for(:event, :invalid_dates), format: :js } }

      it 'does not save the new answer in the database' do
        expect { subject }.to_not change(Event, :count)
      end

      it 're-renders new view' do
        subject
        expect(response).to render_template :new
      end
    end
  end

  describe '#show' do
    before { get :show, params: { id: event.id } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

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

  describe '#edit' do
    before { get :edit, params: { id: event.id } }

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      it 'assigns the requested event to event' do
        patch :update, params: { id: event, event: attributes_for(:event), format: :js }
        expect(event).to eq event
      end

      it 'changes event attributes' do
        patch :update, params: { id: event, event: { title: 'new title' } }, format: :js
        event.reload
        expect(event.title).to eq 'new title'
      end

      it 'redirect to updated event' do
        patch :update, params: { id: event.id, event: attributes_for(:event), format: :js }

        expect(response).to redirect_to event_path(Event.last)
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: event, event: attributes_for(:event, :invalid_dates), format: :js } }

      it 'does not change event' do
        event.reload
        expect(event.title).to eq 'Title 29'
      end

      it 're-renders edit view' do
        expect(response).to render_template(:edit)
      end
    end
  end
end
