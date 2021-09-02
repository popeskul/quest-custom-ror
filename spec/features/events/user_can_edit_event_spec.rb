# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit an event', '
  In order to update an event, user need to go
  to the show page and fill form
' do
  given!(:event) { create(:event) }
  given!(:user) { create(:user) }

  describe 'Authenticated user can edit event' do
    background do
      sign_in(user)
      visit event_path(event)
      click_on 'Edit Event'
    end

    scenario 'form with valid attributes' do
      title = 'title title'

      within '.edit_event' do
        fill_in 'Title', with: title

        click_on t('helpers.submit.event.update')
      end

      expect(page).to have_content t('.events.update.success')
      expect(page).to have_content title
    end
  end
end
