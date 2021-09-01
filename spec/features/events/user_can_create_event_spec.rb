require 'rails_helper'

feature 'User can create an event', '
  In order to create an event, user need to go
  to the form page and fill the form
' do
  # given!(:create_events) { create_list(:event, 15) }

  describe 'User can create form' do
    background { visit new_event_path }

    scenario 'form with valid attributes' do
      title = 'title title'

      within '.new_event' do
        fill_in 'Title', with: title
        fill_in 'Description', with: 'text text'
        fill_in 'Location', with: 'location location'
        fill_in 'Organizeremail', with: 'email@mail.com'

        within '.event_starttime' do
          have_select 'event_starttime_1i', selected: '2021'
          have_select 'event_starttime_2i', selected: 'September'
          have_select 'event_starttime_3i', selected: '1'
          have_select 'event_starttime_4i', selected: '01'
          have_select 'event_starttime_5i', selected: '01'
        end

        within '.event_endtime' do
          have_select 'event_endtime_1i', selected: '2021'
          have_select 'event_endtime_2i', selected: 'October'
          have_select 'event_endtime_3i', selected: '1'
          have_select 'event_endtime_4i', selected: '01'
          have_select 'event_endtime_5i', selected: '01'
        end

        click_on 'Create Event'
      end

      expect(page).to have_content 'Your event successfully created.'
      expect(page).to have_content title
    end

    scenario 'form with invalid attributes' do
      within '.new_event' do
        click_on 'Create Event'
      end

      expect(page).to have_content "Title can't be blank"
    end
  end
end
