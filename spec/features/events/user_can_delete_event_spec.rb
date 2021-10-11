# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete an event', '
  In order to delete an event, user need to go
  to the show page and press delete button
' do
  given!(:existing_admin) { create(:user, admin: true) }
  given!(:existing_user) { create(:user) }

  given!(:existing_event) { create(:event, author_id: existing_admin.id) }
  given!(:existing_event2) { create(:event, author_id: existing_user.id) }

  context 'as admin' do
    background { sign_in(existing_admin) }

    include_examples 'Delete an event' do
      let(:event) { existing_event }
    end

    context 'can delete not his event' do
      include_examples 'Delete an event' do
        let(:user) { existing_user }
        let(:event) { existing_event }
      end
    end
  end

  describe 'as user' do
    background { sign_in(existing_user) }

    include_examples 'Delete an event' do
      let(:event) { existing_event2 }
    end

    scenario 'can not delete not his own event' do
      visit event_path(existing_event)

      click_on t('.admin.events.show.button.delete')

      expect(page).to_not have_content t('.admin.events.destroy.success')
    end
  end
end
