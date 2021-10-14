# frozen_string_literal: true

require 'rails_helper'

feature 'User can navigate events', '
  In order to view events, user can navigate
  by pagination
' do
  given!(:existing_user) { create(:user) }
  given(:create_events) { create_list(:event, 15, author_id: existing_user.id, aasm_state: 'approved') }

  describe 'Authenticated user can navigate events' do
    before do
      sign_in(existing_user)
      create_events
      visit events_path
    end

    it 'User can view first approved page' do
      within '.events' do
        expect(page).to have_selector('.event', count: 10)
      end
    end

    it 'User can move to the second approved page' do
      within('.pagination') { click_link '2' }

      expect(page).to have_selector('.event', count: 5)
    end
  end
end
