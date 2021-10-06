# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete an event', '
  In order to delete an event, user need to go
  to the show page and press delete button
' do
  given!(:admin) { create(:user, admin: true) }
  given!(:user) { create(:user) }

  given!(:event) { create(:event, author_id: admin.id) }

  context 'Authenticated user can delete event' do
    describe 'as admin' do
      background do
        sign_in(admin)
        visit admin_event_path(event)
      end

      scenario 'can delete his own event' do
        click_on t('.admin.events.show.button.delete')

        expect(page).to have_content t('.admin.events.destroy.success')
      end
    end
  end
end
