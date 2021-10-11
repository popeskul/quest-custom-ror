# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete an event', '
  In order to delete an event, user need to go
  to the show page and press delete button
' do
  given!(:admin) { create(:user, admin: true) }
  given!(:user) { create(:user) }

  given!(:event) { create(:event, author_id: admin.id) }
  given!(:event2) { create(:event, author_id: user.id) }

  describe 'as admin' do
    background { sign_in(admin) }

    it_behaves_like 'Delete an event'

    context 'can delete not his event' do
      it_behaves_like 'Delete an event' do
        let(:event) { event2 }
      end
    end
  end

  describe 'as user' do
    background { sign_in(user) }

    it_behaves_like 'Delete an event' do
      let(:event) { event2 }
    end

    scenario 'can not delete not his own event' do
      visit event_path(event)

      click_on t('.admin.events.show.button.delete')

      expect(page).to_not have_content t('.admin.events.destroy.success')
    end
  end
end
