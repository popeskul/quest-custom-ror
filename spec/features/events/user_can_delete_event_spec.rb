# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete an event', '
  In order to delete an event, user need to go
  to the show page and press delete button
' do
  given!(:user) { create(:user) }
  given!(:event) { create(:event, author_id: user.id) }

  describe 'Authenticated user can delete event' do
    background do
      sign_in(user)
      visit event_path(event)
    end

    scenario 'can delete his own event' do
      click_on t('.events.show.button.delete')

      expect(page).to have_content t('.events.destroy.success')
    end
  end
end
