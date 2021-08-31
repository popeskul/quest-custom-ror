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

    it 'assigns a new Question to @question' do
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

  describe 'GET #show' do
    before { get :show, params: { id: event.id } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
