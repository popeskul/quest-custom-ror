# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { create(:event) }
  let!(:user) { create(:user) }

  before { login(user) }

  describe '#edit' do
    before { get :edit, params: { id: event.id } }

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end
end
