require 'rails_helper'

feature 'User can create an event', '
  In order to create an event, user need to go
  to the form page and fill the form
' do
  # given!(:create_events) { create_list(:event, 15) }

  background { visit new_event_path }

  describe 'User' do
    scenario 'User can create form' do
      starttime = DateTime.new(2021, 10, 28, 0, 0, 0)
      endtime   = DateTime.new(2021, 10, 29, 0, 0, 0)

      within '.new_event' do
        fill_in 'Title', with: 'title title'
        fill_in 'Description', with: 'text text'
        fill_in 'Location', with: 'location location'
        fill_in 'Organizeremail', with: 'email@mail.com'
        # fill_in 'Organizertelegram', with: ''
        # fill_in 'Link', with: 'email@mail.com'
        have_select 'Language'
        # fill_in 'Starttime', with: starttime
        # fill_in 'Endtime', with: endtime


        click_on 'Ask'
      end
    end
  end
end
