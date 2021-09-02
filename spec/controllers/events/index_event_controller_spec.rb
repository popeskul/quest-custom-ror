# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { create(:event) }
  let!(:user) { create(:user) }

  before { login(user) }

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
end
