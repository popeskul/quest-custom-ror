# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit an event', '
  In order to update an event, user need to go
  to the show page and fill form
' do
  given!(:existing_admin) { create(:user, admin: true) }
  given!(:existing_admin2) { create(:user, admin: true) }

  given!(:existing_event) { create(:event, author_id: existing_admin.id) }
  given!(:existing_event2) { create(:event, author_id: existing_admin2.id) }

  context 'Authenticated user' do
    describe 'as admin' do
      background { sign_in(existing_admin) }

      describe 'can edit his own event' do
        before do
          visit event_path(existing_event)
          click_on 'Edit Event'
        end

        it_behaves_like 'Update en event by form'
      end

      describe 'can edit not his own event' do
        before do
          visit event_path(existing_event2)
          click_on 'Edit Event'
        end

        it_behaves_like 'Update en event by form'
      end
    end
  end
end
