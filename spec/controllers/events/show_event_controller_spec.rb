# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { create(:event) }
  let!(:user) { create(:user) }

  before { login(user) }

  describe '#show' do
    before { get :show, params: { id: event.id } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
