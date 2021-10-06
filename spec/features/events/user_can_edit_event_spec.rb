# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit an event', '
  In order to update an event, user need to go
  to the show page and fill form
' do
  given!(:admin) { create(:user, admin: true) }
  given!(:event) { create(:event, author_id: admin.id) }

  context 'Authenticated user can edit event' do
    describe 'as admin' do
      background do
        sign_in(admin)
        visit event_path(event)
        click_on 'Edit Event'
      end

      scenario 'form with valid attributes' do
        title = 'title title'

        within '.edit_event' do
          fill_in 'Title', with: title

          click_on t('helpers.submit.admin.event.update')
        end

        expect(page).to have_content t('.admin.events.update.success')
        expect(page).to have_content title
      end
    end
  end
end
