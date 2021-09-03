# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let!(:user) { create(:user) }
  let(:event) { create(:event, author_id: user.id) }

  before { login(user) }

  describe '#index' do
    let(:events) { create_list(:event, 15, author_id: user.id) }

    before { get :index }

    it 'returns the correct array of events' do
      expect(events).to match_array(events)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
