# frozen_string_literal: true

require 'rails_helper'

feature 'User can moderate an event', '
  In order to moderate an event, user need to go
  to the form page and fill the form
' do
  context 'Authenticated user' do
    context 'as Admin' do
      given!(:existing_admin) { create(:user, admin: true) }

      describe 'with his own event' do
        given!(:existing_event) { create(:event, author: existing_admin) }

        background do
          sign_in(existing_admin)
          visit admin_moderation_events_url
        end

        it 'approve an event' do
          click_on t('admin.events.event.approve')

          expect(body).to have_content t('admin.moderation_events.approve.approved')
        end

        it 'decline an event' do
          click_on t('admin.events.event.decline')

          expect(body).to have_content t('admin.moderation_events.decline.declined')
        end
      end

      describe 'with not his own event' do
        given!(:existing_event) { create(:event) }

        background do
          sign_in(existing_admin)
          visit admin_moderation_events_url
        end

        it 'approve an event' do
          click_on t('admin.events.event.approve')

          expect(body).to have_content t('admin.moderation_events.approve.approved')
        end

        it 'decline an event' do
          click_on t('admin.events.event.decline')

          expect(body).to have_content t('admin.moderation_events.decline.declined')
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
        expect(body).to have_content t('shared.errors.not_authorized')
      end
    end
  end
end
