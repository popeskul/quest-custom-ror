# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::CreateEvent do
  let(:existing_user) { create(:user) }
  let(:options) { attributes_for(:event, event_postable: existing_user) }
  let(:create_event) { Services::CreateEvent.new(existing_user, options).call }

  describe '#call' do
    it 'invoke the call method and return correct object' do
      expect(create_event.title).to eq options[:title]
    end
  end
end
