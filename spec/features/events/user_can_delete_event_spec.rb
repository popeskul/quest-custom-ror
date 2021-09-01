require 'rails_helper'

feature 'User can delete an event', '
  In order to delete an event, user need to go
  to the show page and press delete button
' do
  given!(:event) { create(:event) }

  describe 'User can delete event' do
    background { visit event_path(event) }

    scenario 'successfully delete' do
      click_on t('.events.show.button.delete')

      expect(page).to have_content t('.events.destroy.success')
    end
  end
end
