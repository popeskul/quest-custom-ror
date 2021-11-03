# frozen_string_literal: true

require 'rails_helper'

feature 'User can create an event', '
  In order to create an event, user need to go
  to the form page and fill the form
' do
  context 'Authenticated user' do
    given!(:existing_admin) { create(:staff) }
    given!(:existing_user) { create(:user) }
    given!(:existing_tags) { create_list(:tag, 2) }

    context 'as admin' do
      background do
        sign_in(existing_admin)
        visit new_event_path
      end

      include_examples 'Create an event'
    end

    context 'as user' do
      background do
        sign_in(existing_user)
        visit new_event_path
      end

      include_examples 'Create an event'
    end
  end
end
