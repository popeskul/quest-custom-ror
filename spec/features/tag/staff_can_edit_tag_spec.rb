# frozen_string_literal: true

require 'rails_helper'

feature 'Staff can edit a tag', '
  In order to edit a tag, staff need to
  fill form
' do
  context 'Authenticated user' do
    context 'as Admin' do
      given!(:existing_admin) { create(:staff) }
      given!(:existing_tag)   { create(:tag) }

      describe 'go to the edit tag page' do
        background do
          sign_in(existing_admin)
          visit edit_admin_tag_path(existing_tag)
        end

        it 'edit tag' do
          tag_name = 'new tag name'

          within '.edit_acts_as_taggable_on_tag' do
            fill_in t('.simple_form.labels.admin.tag.name'), with: tag_name

            click_on t('.helpers.submit.acts_as_taggable_on_tag.update')
          end

          expect(page).to have_content t('admin.tags.update.success')
          expect(page).to have_content tag_name
        end
      end
    end
  end
end
