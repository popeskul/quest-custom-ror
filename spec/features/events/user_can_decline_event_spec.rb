# frozen_string_literal: true

require 'rails_helper'

feature 'User can decline an event', '
  In order to decline an event, user need to go
  to the form page and fill the form
' do
  context 'Authenticated user' do
    context 'as Admin' do
      given!(:existing_admin) { create(:staff) }
      given!(:create_event) { create(:event, event_postable: existing_admin) }

      background do
        sign_in(existing_admin)
        visit admin_moderation_events_url
      end

      describe 'with his own event' do
        it 'decline an event' do
          click_on t('admin.events.event.approve')
          click_on t('admin.events.event.decline')

          expect(body).to have_content t('admin.moderation_events.decline.success')
        end
      end

      describe 'with not his own event' do
        it 'decline an event' do
          click_on t('admin.events.event.approve')
          click_on t('admin.events.event.decline')

          expect(body).to have_content t('admin.moderation_events.decline.success')
        end
      end
    end

    context 'as not Admin' do
      given!(:existing_user) { create(:user) }

      background do
        sign_in(existing_user)
        visit admin_moderation_events_url
      end

      it 'can not navigate to moderation events page' do
        expect(body).to have_content t('devise.failure.unauthenticated')
      end
    end
  end
end
