# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete an event', '
  In order to delete an event, user need to go
  to the show page and press delete button
' do
  given!(:event) { create(:event) }
  given!(:user) { create(:user) }

  describe 'Authenticated user can delete event' do
    background do
      sign_in(user)
      visit event_path(event)
    end

    scenario 'successfully delete' do
      click_on t('.events.show.button.delete')

      expect(page).to have_content t('.events.destroy.success')
    end
  end
end
