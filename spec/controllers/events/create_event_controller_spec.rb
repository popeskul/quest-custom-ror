# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { create(:event) }
  let!(:user) { create(:user) }

  before { login(user) }

  describe '#create' do
    context 'with valid attributes' do
      subject { post :create, params: { event: attributes_for(:event), format: :js } }

      it 'save a new event' do
        expect { subject }.to change(Event, :count).by(1)
      end

      it 'redirects to show' do
        subject
        expect(response).to redirect_to assigns(:event)
      end
    end

    context 'with invalid attributes' do
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
end
