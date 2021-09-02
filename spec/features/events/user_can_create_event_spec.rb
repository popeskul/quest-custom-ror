require 'rails_helper'

feature 'User can create an event', '
  In order to create an event, user need to go
  to the form page and fill the form
' do
  describe 'Authenticated user' do
    given!(:user) { create(:user) }

    background do
      visit new_event_path
      sign_in(user)
    end

    scenario 'User can create event with valid attributes' do
      title = 'title title'

      within '.new_event' do
        fill_in t('.simple_form.labels.event.title'), with: title
        fill_in t('.simple_form.labels.event.location'), with: 'location location'
        fill_in t('.simple_form.labels.event.organizer_email'), with: 'email@mail.com'

        within '.event_start_time' do
          have_select 'event_start_time_1i', selected: '2021'
          have_select 'event_start_time_2i', selected: 'September'
          have_select 'event_start_time_3i', selected: '1'
        end

        within '.event_end_time' do
          have_select '#event_end_time_1i', selected: '2022'
          have_select '#event_end_time_2i', selected: 'September'
          have_select '#event_end_time_3i', selected: '1'
        end

        click_on t('helpers.submit.event.create')
      end

      expect(page).to have_content t('.events.create.success')
      expect(page).to have_content title
    end
  end
end
