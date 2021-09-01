require 'rails_helper'

feature 'User can edit an event', '
  In order to update an event, user need to go
  to the show page and fill form
' do
  given!(:event) { create(:event) }

  describe 'User can edit event' do
    background do
      visit event_path(event)
      click_on 'Edit event'
    end

    scenario 'form with valid attributes' do
      title = 'title title'

      within '.edit_event' do
        fill_in 'Title', with: title

        click_on 'Update Event'
      end

      expect(page).to have_content 'Your event successfully updated.'
      expect(page).to have_content title
    end

    scenario 'form with invalid attributes' do
      within '.edit_event' do
        fill_in 'Title', with: ''

        click_on 'Update Event'
      end

      expect(page).to have_content "Title can't be blank"
    end
  end
end
