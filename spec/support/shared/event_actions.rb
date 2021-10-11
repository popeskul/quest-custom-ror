# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'Update en event by form' do
  scenario 'save an event with valid attributes' do
    title = 'title title'

    within '.edit_event' do
      fill_in 'Title', with: title

      click_on t('helpers.submit.admin.event.update')
    end

    expect(page).to have_content t('.admin.events.update.success')
    expect(page).to have_content title
  end
end

shared_examples_for 'Delete an event' do
  it 'can delete an event' do
    visit event_path(event)

    click_on t('.admin.events.show.button.delete')

    expect(page).to have_content t('.admin.events.destroy.success')
  end
end

shared_examples_for 'Create an event' do
  it 'create an event' do
    title = 'title title'

    within '.new_event' do
      fill_in t('.simple_form.labels.admin.event.title'), with: title
      fill_in t('.simple_form.labels.admin.event.location'), with: 'location location'
      fill_in t('.simple_form.labels.admin.event.organizer_email'), with: 'email@mail.com'

      fill_in t('.simple_form.labels.admin.event.start_time'), with: '2021-09-03'
      fill_in t('.simple_form.labels.admin.event.end_time'), with: '2022-09-03'

      click_on t('helpers.submit.admin.event.create')
    end

    expect(page).to have_content t('.admin.events.create.success')
    expect(page).to have_content title
  end
end
