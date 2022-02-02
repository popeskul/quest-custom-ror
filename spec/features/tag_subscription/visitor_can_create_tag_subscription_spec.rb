# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor can create tag subscription', '
  In order to create tag subscription, visitor need to go
  to the tag subscription page
' do
  email = 'test@mail.com'

  context 'as Visitor' do
    let!(:existing_tag) { create(:tag, name: 'ruby', keys: 'backend') }

    describe 'go to the new tag subscription page' do
      background { visit new_tag_subscription_url }

      it 'see form' do
        expect(body).to have_content t('tag_subscriptions.title')
      end

      describe 'with valid data' do
        it 'fill form' do
          within '.new_tag_subscription' do
            fill_in t('.simple_form.labels.tag_subscription.new.email'), with: email
            find(:css, "#tag_subscription_tags_#{existing_tag.name}").set(true)

            click_on t('helpers.submit.tag_subscription.create')
          end

          expect(page).to have_content t('tag_subscriptions.create.success')
        end
      end

      describe 'with invalid data' do
        it 'fill form' do
          within '.new_tag_subscription' do
            fill_in t('.simple_form.labels.tag_subscription.new.email'), with: email

            click_on t('helpers.submit.tag_subscription.create')
          end

          expect(page).to_not have_content t('tag_subscriptions.create.success')
        end
      end
    end
  end
end
