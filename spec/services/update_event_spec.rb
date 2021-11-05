# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::UpdateEvent do
  let(:existing_user) { create(:user) }
  let(:options) { attributes_for(:event) }
  let(:existing_event) { create(:event, options) }
  let(:update_event) { Services::UpdateEvent.new(existing_event, options).call }

  describe '#call' do
    it 'invoke the call method and return correct object' do
      update_event
      expect(Event.last.title).to eq options[:title]
    end
  end
end
