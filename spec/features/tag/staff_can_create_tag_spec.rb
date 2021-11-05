# frozen_string_literal: true

require 'rails_helper'

feature 'Staff can create a tag', '
  In order to create a tag, staff need to
  fill form
' do
  context 'Authenticated user' do
    context 'as Admin' do
      given!(:existing_admin) { create(:staff) }

      describe 'go to the new tag page' do
        background do
          sign_in(existing_admin)
          visit new_admin_tag_url
        end

        it 'create tag' do
          tag_name = 'new tag name'
          tag_keys = 'ruby, backend'

          within '.new_acts_as_taggable_on_tag' do
            fill_in t('.simple_form.labels.admin.tag.name'), with: tag_name
            fill_in t('.simple_form.labels.admin.tag.keys'), with: tag_keys

            click_on t('helpers.submit./admin/tags/new.submit')
          end

          expect(page).to have_content t('admin.tags.create.success')
          expect(page).to have_content tag_name
          expect(page).to have_content tag_keys
        end
      end
    end
  end
end
