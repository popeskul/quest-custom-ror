# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::CreateEvent do
  let(:existing_user) { create(:user) }
  let(:options) { attributes_for(:event, author_id: existing_user.id) }
  let(:create_event) { Services::CreateEvent.new(options).call }

  describe '#call' do
    it 'invoke the call method and return correct object' do
      expect(create_event.author_id).to eq options[:author_id]
      expect(create_event.title).to eq options[:title]
    end
  end
end
