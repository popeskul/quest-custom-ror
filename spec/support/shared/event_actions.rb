# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'Update en event by form' do
  scenario 'save an event with valid attributes' do
    title = 'title title'
    tag_name = ActsAsTaggableOn::Tag.first.name

    within '.edit_event' do
      fill_in 'Title', with: title
      select tag_name, from: 'event[tag_list][]'

      click_on t('helpers.submit.event.update')
    end

    expect(page).to have_content t('.admin.events.update.success')
    expect(page).to have_content title
    expect(page).to have_content tag_name
  end
end

shared_examples_for 'Delete an event' do
  it 'can delete an event' do
    visit event_path(event)

    click_on t('.events.show.button.delete')

    expect(page).to have_content t('.admin.events.destroy.success')
  end
end

shared_examples_for 'Create an event' do
  it 'create an event' do
    title = 'title title'
    tag_name = ActsAsTaggableOn::Tag.first.name

    within '.new_event' do
      fill_in t('.simple_form.labels.event.title'), with: title
      fill_in t('.simple_form.labels.event.location'), with: 'location location'
      fill_in t('.simple_form.labels.event.organizer_email'), with: 'email@mail.com'

      fill_in t('.simple_form.labels.event.start_time'), with: '2021-09-03'
      fill_in t('.simple_form.labels.event.end_time'), with: '2022-09-03'
      select tag_name, from: 'event[tag_list][]'

      click_on t('events.index.button.create')
    end

    expect(page).to have_content t('.events.create.success')
    expect(page).to have_content title
    expect(page).to have_content tag_name
  end
end
