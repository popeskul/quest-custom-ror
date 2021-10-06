# frozen_string_literal: true

require 'rails_helper'

feature 'User can create an event', '
  In order to create an event, user need to go
  to the form page and fill the form
' do
  context 'Authenticated user' do
    describe 'as admin' do
      given!(:admin) { create(:user, admin: true ) }

      background do
        sign_in(admin)
        visit new_admin_event_path
      end

      scenario 'User can create event with valid attributes' do
        title = 'title title'

        within '.new_event' do
          fill_in t('.simple_form.labels.admin.event.title'), with: title
          fill_in t('.simple_form.labels.admin.event.location'), with: 'location location'
          fill_in t('.simple_form.labels.admin.event.organizer_email'), with: 'email@mail.com'

          fill_in t('.simple_form.labels.admin.event.start_time'), with: '2021-09-03'
          fill_in t('.simple_form.labels.admin.event.end_time'), with: '2022-09-03'

          click_on t('helpers.submit.admin.event.create')
        end

        expect(page).to have_content t('.admin.events.create.success')
        expect(page).to have_content title
      end
    end
  end
end
