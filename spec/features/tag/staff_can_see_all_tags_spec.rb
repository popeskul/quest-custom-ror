# frozen_string_literal: true

require 'rails_helper'

feature 'Staff can see all tags', '
  In order to see all tags, staff need to go
  to the tag page
' do
  context 'Authenticated user' do
    context 'as Admin' do
      given!(:existing_admin) { create(:staff) }
      given!(:existing_tags) { create_list(:tag, 2) }

      describe 'go to the tag page' do
        background do
          sign_in(existing_admin)
          visit admin_tags_url
        end

        it 'see all tags' do
          expect(body).to have_content existing_tags.first.name
        end
      end
    end

    context 'as not Admin' do
      given!(:existing_user) { create(:user) }

      background do
        sign_in(existing_user)
        visit admin_tags_url
      end

      it 'can not navigate to moderation events page' do
        expect(body).to have_content t('devise.failure.unauthenticated')
      end
    end
  end
end
