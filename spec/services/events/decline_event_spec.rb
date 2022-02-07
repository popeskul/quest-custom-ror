# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Services::DeclineEvent do
  let(:existing_event) { build(:event) }

  let(:decline_event) { Events::Services::DeclineEvent.new(existing_event) }

  describe '#call' do
    it 'user approve' do
      expect { decline_event.call }.to change { existing_event.aasm_state }.to 'declined'
    end

    it 'user can not decline twice' do
      decline_event.call
      expect(decline_event.call).to eq false
    end
  end
end
