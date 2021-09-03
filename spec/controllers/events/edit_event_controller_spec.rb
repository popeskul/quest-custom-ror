# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let!(:user) { create(:user) }
  let(:event) { create(:event, author_id: user.id) }

  before { login(user) }

  describe '#edit' do
    before { get :edit, params: { id: event.id } }

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end
end
