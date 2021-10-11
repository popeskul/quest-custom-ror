# frozen_string_literal: true

require 'rails_helper'

feature 'User can create an event', '
  In order to create an event, user need to go
  to the form page and fill the form
' do
  context 'Authenticated user' do
    given!(:admin) { create(:user, admin: true) }
    given!(:user) { create(:user) }

    context 'as admin' do
      background do
        sign_in(admin)
        visit new_event_path
      end

      include_examples 'Create an event'
    end

    context 'as user' do
      background do
        sign_in(user)
        visit new_event_path
      end

      include_examples 'Create an event'
    end
  end
end
