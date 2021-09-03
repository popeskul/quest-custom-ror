# frozen_string_literal: true

require 'rails_helper'

feature 'User can create an event', '
  In order to create an event, user need to go
  to the form page and fill the form
' do
  describe 'Authenticated user' do
    given!(:user) { create(:user) }

    background do
      sign_in(user)
      visit new_event_path
    end

    scenario 'User can create event with valid attributes' do
      title = 'title title'

      within '.new_event' do
        fill_in t('.simple_form.labels.event.title'), with: title
        fill_in t('.simple_form.labels.event.location'), with: 'location location'
        fill_in t('.simple_form.labels.event.organizer_email'), with: 'email@mail.com'

        fill_in t('.simple_form.labels.event.start_time'), with: '2021-09-03'
        fill_in t('.simple_form.labels.event.end_time'), with: '2022-09-03'

        click_on t('helpers.submit.event.create')
      end

      expect(page).to have_content t('.events.create.success')
      expect(page).to have_content title
    end
  end
end
